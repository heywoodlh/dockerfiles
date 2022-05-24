FROM mcr.microsoft.com/playwright:focal 
LABEL maintainer=heywoodlh

RUN npm install -g feed-me-up-scotty

RUN mkdir -p /app

WORKDIR /app
VOLUME /app/feeds.toml
VOLUME /app/public

ENTRYPOINT ["npx", "feed-me-up-scotty"]
