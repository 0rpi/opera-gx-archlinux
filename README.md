# Opera GX - Arch Linux

PKGBUILD for [Opera GX](https://www.opera.com/gx) on Arch Linux, automatically updated via GitHub Actions.

The package is built from the official Opera GX `.deb` package.

## Installation

    git clone https://github.com/0rpi/opera-gx-archlinux.git
    cd opera-gx-archlinux
    ./install.sh

## Update

    cd opera-gx-archlinux
    git pull
    ./install.sh

## How it works

A GitHub Actions workflow checks daily for new Opera GX versions from the Opera official apt repository. When a new version is found, the PKGBUILD is automatically updated via a commit.

Just `git pull && ./install.sh` to get the latest version.

## Requirements

- Arch Linux (or Arch-based distro)
- `base-devel` package group
- `curl` and `gzip` (for version detection)
