# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Campagnol is a decentralized VPN over UDP tunneling."
HOMEPAGE="http://campagnol.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="server"

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable server)
} 

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc Changelog README TODO
}

pkg_postinst() {
	elog "You will need the Universal TUN/TAP driver compiled into"
	elog "your kernel or as a module to use ${PN}."
}

