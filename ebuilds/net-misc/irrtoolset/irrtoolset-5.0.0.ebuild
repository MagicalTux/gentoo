# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="IRRToolSet is a set of tools provided by ISC to manage router
configurations through whois updates"
HOMEPAGE="http://irrtoolset.isc.org/"
SRC_URI="http://rsync.au.gentoo.org/isc/IRRToolSet/IRRToolSet-${PV}/irrtoolset-${PV}.tar.gz"

LICENSE="GPL-2" # also USC and RIPE NCC license (TODO add)
SLOT="0"
KEYWORDS="~amd64"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use !readline || echo --disable-readline)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc COPYING NEWS README RELEASE-NOTES
}


