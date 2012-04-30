# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2

DESCRIPTION="invpn is a decentralized secure VPN server"
HOMEPAGE="https://github.com/MagicalTux/invpn"
SRC_URI="http://cloud.github.com/downloads/MagicalTux/invpn/invpn-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README.md"

qt4-r2_src_install() {
	# do normal install
	qt4-r2_src_install
	# install gentoo support files
	mkdir -p "${D}/etc/init.d"
	mkdir -p "${D}/etc/invpn"
	cp extra/gentoo/invpn "${D}/etc/init.d/invpn"
	dodoc "${D}/etc/init.d/invpn.conf"
}

