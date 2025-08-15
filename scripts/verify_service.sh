#!/bin/bash
set -euo pipefail

# Wait a bit for the service to be ready
sleep 3

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health || true)
if [ "$STATUS_CODE" != "200" ]; then
  echo "Health check failed, status: $STATUS_CODE"
  systemctl status nodeapp --no-pager || true
  journalctl -u nodeapp --no-pager -n 200 || true
  exit 1
fi

echo "Health check passed"
