#!/usr/bin/env node
'use strict';

const http = require('node:http');
const net = require('node:net');

const upstreamPort = Number(process.argv[2]);
if (!Number.isInteger(upstreamPort) || upstreamPort < 1 || upstreamPort > 65535) {
  throw new Error('usage: reverse-proxy.js <Grayjay loopback port>');
}

function publicOrigin(request) {
  const forwardedHost = request.headers['x-forwarded-host'];
  const host = (Array.isArray(forwardedHost) ? forwardedHost[0] : forwardedHost) || request.headers.host;
  const forwardedProto = request.headers['x-forwarded-proto'];
  const protocol = (Array.isArray(forwardedProto) ? forwardedProto[0] : forwardedProto) || 'http';
  if (typeof host !== 'string' || !/^[A-Za-z0-9.:[\]-]+$/.test(host) || !/^(http|https)$/.test(protocol)) {
    return null;
  }
  return `${protocol}://${host}`;
}

function upstreamFor(request) {
  const match = /^\/_grayjay_proxy\/(\d{1,5})(\/.*)?$/.exec(request.url);
  if (!match) {
    return { port: upstreamPort, path: request.url };
  }
  const port = Number(match[1]);
  if (port < 1024 || port > 65535) {
    return null;
  }
  return { port, path: match[2] || '/' };
}

function copyHeaders(headers) {
  const copied = { ...headers };
  delete copied.host;
  delete copied.connection;
  delete copied['content-length'];
  return copied;
}

const server = http.createServer((request, response) => {
  const upstream = upstreamFor(request);
  if (!upstream) {
    response.writeHead(400).end('invalid Grayjay proxy port');
    return;
  }

  const upstreamRequest = http.request({
    hostname: '127.0.0.1',
    port: upstream.port,
    method: request.method,
    path: upstream.path,
    headers: copyHeaders(request.headers),
  }, (upstreamResponse) => {
    const contentType = upstreamResponse.headers['content-type'] || '';
    const shouldRewrite = typeof contentType === 'string' && contentType.includes('application/dash+xml');
    if (!shouldRewrite) {
      response.writeHead(upstreamResponse.statusCode || 502, upstreamResponse.headers);
      upstreamResponse.pipe(response);
      return;
    }

    const chunks = [];
    upstreamResponse.on('data', chunk => chunks.push(chunk));
    upstreamResponse.on('end', () => {
      const origin = publicOrigin(request);
      const headers = { ...upstreamResponse.headers };
      delete headers['content-length'];
      const body = Buffer.concat(chunks).toString('utf8').replace(
        /http:\/\/127\.0\.0\.1:(\d{1,5})\//g,
        (_, port) => origin ? `${origin}/_grayjay_proxy/${port}/` : `/_grayjay_proxy/${port}/`,
      );
      response.writeHead(upstreamResponse.statusCode || 502, headers);
      response.end(body);
    });
  });
  upstreamRequest.on('error', error => {
    response.writeHead(502).end(`Grayjay upstream error: ${error.message}`);
  });
  request.pipe(upstreamRequest);
});

server.on('upgrade', (request, socket, head) => {
  const upstream = upstreamFor(request);
  if (!upstream) {
    socket.destroy();
    return;
  }
  const upstreamSocket = net.connect(upstream.port, '127.0.0.1', () => {
    const headers = copyHeaders(request.headers);
    headers.host = `127.0.0.1:${upstream.port}`;
    headers.connection = 'Upgrade';
    headers.upgrade = request.headers.upgrade || 'websocket';
    const lines = [`${request.method} ${upstream.path} HTTP/${request.httpVersion}`];
    for (const [name, value] of Object.entries(headers)) {
      lines.push(`${name}: ${value}`);
    }
    upstreamSocket.write(`${lines.join('\r\n')}\r\n\r\n`);
    if (head.length) upstreamSocket.write(head);
    socket.pipe(upstreamSocket).pipe(socket);
  });
  upstreamSocket.on('error', () => socket.destroy());
  socket.on('error', () => upstreamSocket.destroy());
});

server.listen(11338, '0.0.0.0');
