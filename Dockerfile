FROM oven/bun:1
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . /app
ENV GBRAIN_UPGRADE_OWNS_MIGRATIONS=1 GBRAIN_NO_AUTOPILOT_INSTALL=1
RUN bun install --frozen-lockfile
RUN printf '#!/bin/sh\nexec bun /app/src/cli.ts "$@"\n' > /usr/local/bin/gbrain && chmod +x /usr/local/bin/gbrain \
 && chmod +x /app/docker-entrypoint.sh
ENV GBRAIN_HOME=/data
VOLUME /data
EXPOSE 3131
ENTRYPOINT ["/app/docker-entrypoint.sh"]
