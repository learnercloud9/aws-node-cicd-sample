#!/bin/bash
set -euo pipefail

SERVICE_NAME=nodeapp
SERVICE_FILE=/etc/systemd/system/${SERVICE_NAME}.service

cat > ${SERVICE_FILE} << 'UNIT'
[Unit]
Description=Node.js Sample App
After=network.target

[Service]
Type=simple
User=nodeapp
WorkingDirectory=/opt/nodeapp
Environment=PORT=3000
ExecStart=/usr/bin/node /opt/nodeapp/server.js
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
UNIT

# Reload and restart
systemctl daemon-reload
systemctl enable ${SERVICE_NAME}
# If running, stop first to pick up new code
systemctl stop ${SERVICE_NAME} || true
systemctl start ${SERVICE_NAME}
