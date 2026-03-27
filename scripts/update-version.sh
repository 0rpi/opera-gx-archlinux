#!/bin/bash
# Checks for the latest Opera GX version from the deb repository
# and updates the PKGBUILD if a new version is found.

set -euo pipefail

PKGBUILD="$(dirname "$0")/../PKGBUILD"

echo "Checking latest Opera GX stable version..."

# Fetch the package listing from Opera's deb repo
PACKAGES_URL="https://deb.opera.com/opera-gx-stable/dists/stable/non-free/binary-amd64/Packages.gz"
LATEST_VERSION=$(curl -sL "$PACKAGES_URL" | gunzip 2>/dev/null | grep -A1 "^Package: opera-gx-stable$" | grep "^Version:" | head -1 | awk '{print $2}')

if [ -z "$LATEST_VERSION" ]; then
  echo "ERROR: Could not determine latest version"
  exit 1
fi

CURRENT_VERSION=$(grep "^pkgver=" "$PKGBUILD" | cut -d= -f2)

echo "Current version: $CURRENT_VERSION"
echo "Latest version:  $LATEST_VERSION"

if [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
  echo "Already up to date."
  exit 0
fi

echo "Updating PKGBUILD to version $LATEST_VERSION..."
sed -i "s/^pkgver=.*/pkgver=${LATEST_VERSION}/" "$PKGBUILD"
sed -i "s/^pkgrel=.*/pkgrel=1/" "$PKGBUILD"

# Extract package size and description from Packages metadata
PKG_INFO=$(curl -sL "$PACKAGES_URL" | gunzip 2>/dev/null | awk '/^Package: opera-gx-stable$/,/^$/' | head -30)
PKG_SIZE=$(echo "$PKG_INFO" | grep "^Installed-Size:" | awk '{printf "%.0f Mo", $2/1024}')
PKG_DESCRIPTION=$(echo "$PKG_INFO" | grep "^Description:" | cut -d: -f2- | xargs)

echo "PKGBUILD updated to $LATEST_VERSION"

# Export outputs for GitHub Actions
OUTPUT="${GITHUB_OUTPUT:-/dev/null}"
echo "new_version=$LATEST_VERSION" >> "$OUTPUT"
echo "old_version=$CURRENT_VERSION" >> "$OUTPUT"
echo "pkg_size=$PKG_SIZE" >> "$OUTPUT"
echo "pkg_description=$PKG_DESCRIPTION" >> "$OUTPUT"
