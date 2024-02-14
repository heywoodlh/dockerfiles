FROM node:13-alpine
LABEL maintainer=heywoodlh

RUN apk add --no-cache git shadow
RUN git clone --depth=1 https://github.com/gskinner/regexr /opt/regexr

RUN npm install --global gulp-cli
RUN useradd -M -d /opt/regexr runner && chown runner:runner /opt/regexr
USER runner
WORKDIR /opt/regexr
RUN npm install
EXPOSE 3000
EXPOSE 3001
ENTRYPOINT ["gulp", "--cwd", "/opt/regexr"]
