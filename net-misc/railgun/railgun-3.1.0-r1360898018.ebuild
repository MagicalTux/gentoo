# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Railgun is CloudFlare's proprietary optimization daemon"
HOMEPAGE="http://www.cloudflare.com/railgun"
SRC_URI="http://www.cloudflare.com/static/misc/railgun/ubuntu/railgun-quantal.latest.deb"

LICENSE="CloudFlare-Railgun"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser railgun
}

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	ar x "${A}" data.tar.gz
	unpack data.tar.gz
}

src_compile() {
	:
}

src_install() {
	dobin ./usr/bin/rg-ssl ./usr/bin/rg-listener ./usr/bin/rg-diag
	dodoc ./usr/share/doc/railgun-stable/changelog.gz
	dodoc ./usr/share/doc/railgun-stable/changelog.Debian.gz
	dodoc ./usr/share/doc/railgun-stable/copyright
	mkdir "${D}/etc"
	mv etc/railgun "${D}"
	newinitd "${FILESDIR}/railgun.initd" railgun
}

