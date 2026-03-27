#!/bin/bash
# Fetches the latest version, updates the PKGBUILD, and builds/installs.

set -euo pipefail

cd "$(dirname "$0")"

echo "==> Detecting latest Opera GX version..."
PACKAGES_URL="https://deb.opera.com/opera-gx-stable/dists/stable/non-free/binary-amd64/Packages.gz"
LATEST_VERSION=$(curl -sL "$PACKAGES_URL" | gunzip 2>/dev/null | grep -A1 "^Package: opera-gx-stable$" | grep "^Version:" | head -1 | awk '{print $2}')

if [ -z "$LATEST_VERSION" ]; then
  echo "ERROR: Could not determine latest version from Opera repository"
  exit 1
fi

echo "==> Latest version: $LATEST_VERSION"
sed -i "s/^pkgver=.*/pkgver=${LATEST_VERSION}/" PKGBUILD

echo "==> Building and installing..."
makepkg -si --noconfirm
