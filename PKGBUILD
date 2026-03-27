# Maintainer: 0rpi
# Auto-updated via GitHub Actions

pkgname=opera-gx-stable
pkgver=129.0.5823.26
pkgrel=1
pkgdesc="Opera GX - A browser built for gamers"
arch=('x86_64')
url="https://www.opera.com/gx"
license=('custom:opera')
depends=(
  'alsa-lib'
  'at-spi2-core'
  'cairo'
  'dbus'
  'expat'
  'gcc-libs'
  'glib2'
  'gtk3'
  'libcups'
  'libdrm'
  'libx11'
  'libxcb'
  'libxcomposite'
  'libxdamage'
  'libxext'
  'libxfixes'
  'libxkbcommon'
  'libxrandr'
  'mesa'
  'nspr'
  'nss'
  'pango'
  'hicolor-icon-theme'
  'libnotify'
  'desktop-file-utils'
)
optdepends=(
  'ffmpeg: HTML5 video/audio support'
  'libva: hardware-accelerated video decode'
  'pipewire: screen sharing via WebRTC'
  'upower: battery status'
)
provides=('opera-gx')
conflicts=('opera-gx-beta' 'opera-gx-developer')
options=('!strip' '!emptydirs')

_deb_url="https://deb.opera.com/opera-gx-stable/pool/non-free/o/opera-gx-stable"
source=("opera-gx-stable_${pkgver}_amd64.deb::${_deb_url}/opera-gx-stable_${pkgver}_amd64.deb")
sha256sums=('SKIP')

package() {
  # Extract the data archive from the .deb, keeping original Debian paths
  bsdtar -xf data.tar.xz -C "${pkgdir}/"

  # Fix sandbox permissions (SUID)
  chmod 4755 "${pkgdir}/usr/lib/x86_64-linux-gnu/opera-gx-stable/opera_sandbox" 2>/dev/null || true

  # Install license
  mkdir -p "${pkgdir}/usr/share/licenses/${pkgname}"
  if [ -f "${pkgdir}/usr/share/doc/opera-gx-stable/copyright" ]; then
    ln -s /usr/share/doc/opera-gx-stable/copyright \
      "${pkgdir}/usr/share/licenses/${pkgname}/LICENSE"
  fi
}
