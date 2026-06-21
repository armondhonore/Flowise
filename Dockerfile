FROM mirror.gcr.io/library/node:24-alpine

# Install system dependencies and build tools
RUN apk update && \
    apk add --no-cache \
    libc6-compat \
    python3 \
    make \
    g++ \
    build-base \
    cairo-dev \
    pango-dev \
    chromium \
    curl && \
    npm install -g pnpm@10.26.0

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV NODE_OPTIONS=--max-old-space-size=8192

WORKDIR /usr/src/flowise

# Copy app source
COPY . .

# Install dependencies and build
RUN pnpm install --no-frozen-lockfile && \
    pnpm build:docker

# Give the node user ownership of the application files
RUN chown -R node:node .

# Switch to non-root user
USER node

EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME=0.0.0.0

CMD [ "pnpm", "start" ]