#!/bin/bash
set -euo pipefail

# Detect package manager
if command -v dnf >/dev/null 2>&1; then
  PM=dnf
elif command -v yum >/dev/null 2>&1; then
  PM=yum
else
  echo "Neither dnf nor yum found. Exiting."
  exit 1
fi

# Install Node.js 18 (LTS) if not present
if ! command -v node >/dev/null 2>&1; then
  echo "Installing Node.js 18..."
  if [ "$PM" = "dnf" ]; then
    sudo $PM install -y nodejs npm
  else
    # Amazon Linux 2 path via NodeSource
    curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo -E bash -
    sudo $PM install -y nodejs
  fi
fi

# Ensure /opt/nodeapp exists
mkdir -p /opt/nodeapp
cd /opt/nodeapp

# Install app dependencies
npm ci || npm install

# Create a dedicated user if not exists
id -u nodeapp >/dev/null 2>&1 || useradd -r -s /sbin/nologin nodeapp || true

chown -R nodeapp:nodeapp /opt/nodeapp
