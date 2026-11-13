#!/bin/sh
set -e
cd /app
if [ ! -f "$GBRAIN_HOME/.gbrain/config.json" ]; then
  gbrain init --non-interactive --url "$GBRAIN_DATABASE_URL" --no-embedding
fi
gbrain apply-migrations --yes --no-autopilot-install
exec gbrain serve --http --bind 0.0.0.0 --port 3131 \
  --public-url "${GBRAIN_PUBLIC_URL:-http://localhost:3131}" \
  --surface full --suppress-bootstrap-token
