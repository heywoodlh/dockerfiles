#!/usr/bin/env node
'use strict';

const http = require('node:http');
const net = require('node:net');
const { randomUUID } = require('node:crypto');
const { readFileSync } = require('node:fs');

const upstreamPort = Number(readFileSync('/data/port', 'utf8').trim());
if (!Number.isInteger(upstreamPort) || upstreamPort < 1 || upstreamPort > 65535) {
  throw new Error('Grayjay did not write a valid loopback port');
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

const mediaProxyTokens = new Map();
const mediaProxyTokenTtlMs = 6 * 60 * 60 * 1000;

function issueMediaProxyToken(port) {
  const now = Date.now();
  for (const [token, entry] of mediaProxyTokens) {
    if (entry.expiresAt <= now) mediaProxyTokens.delete(token);
  }
  const token = randomUUID();
  mediaProxyTokens.set(token, { port, expiresAt: now + mediaProxyTokenTtlMs });
  return token;
}

function localPath(value) {
  if (typeof value !== 'string' || !value.startsWith('/')) return null;
  const url = new URL(value, 'https://grayjay.internal');
  if (url.origin !== 'https://grayjay.internal') return null;
  return `${url.pathname}${url.search}`;
}

function upstreamFor(request) {
  const path = localPath(request.url);
  if (!path) return null;
  const isMediaProxyPath = path.startsWith('/_grayjay_proxy/');
  const match = /^\/_grayjay_proxy\/([0-9a-f-]{36})(\/.*)?$/.exec(path);
  if (!match) {
    return isMediaProxyPath ? null : { port: upstreamPort, path };
  }
  const entry = mediaProxyTokens.get(match[1]);
  if (!entry || entry.expiresAt <= Date.now()) {
    mediaProxyTokens.delete(match[1]);
    return null;
  }
  return { port: entry.port, path: match[2] || '/' };
}

function copyHeaders(headers) {
  const copied = Object.create(null);
  for (const [name, value] of Object.entries(headers)) {
    if (!['host', 'connection', 'content-length'].includes(name)) copied[name] = value;
  }
  return copied;
}

function applyResponseHeaders(response, headers, includeContentLength) {
  for (const name of ['content-type', 'content-range', 'accept-ranges', 'cache-control', 'etag', 'last-modified']) {
    const value = headers[name];
    if (typeof value === 'string' || Array.isArray(value)) response.setHeader(name, value);
  }
  if (includeContentLength && typeof headers['content-length'] === 'string') {
    response.setHeader('content-length', headers['content-length']);
  }
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
      response.statusCode = upstreamResponse.statusCode || 502;
      applyResponseHeaders(response, upstreamResponse.headers, true);
      upstreamResponse.pipe(response);
      return;
    }

    const chunks = [];
    upstreamResponse.on('data', chunk => chunks.push(chunk));
    upstreamResponse.on('end', () => {
      const origin = publicOrigin(request);
      const body = Buffer.concat(chunks).toString('utf8').replace(
        /http:\/\/127\.0\.0\.1:(\d{1,5})\//g,
        (_, port) => {
          const path = `/_grayjay_proxy/${issueMediaProxyToken(Number(port))}/`;
          return origin ? `${origin}${path}` : path;
        },
      );
      response.statusCode = upstreamResponse.statusCode || 502;
      applyResponseHeaders(response, upstreamResponse.headers, false);
      response.end(body);
    });
  });
  upstreamRequest.on('error', error => {
    response.statusCode = 502;
    response.end(`Grayjay upstream error: ${error.message}`);
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
