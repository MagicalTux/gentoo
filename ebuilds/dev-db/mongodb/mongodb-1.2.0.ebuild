# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Mongo (from \"humongous\") is a high-performance, open source, schema-free document-oriented  database."
HOMEPAGE="http://www.mongodb.org/"
SRC_URI="http://downloads.mongodb.org/src/${PN}-src-r${PV}.tar.gz"

LICENSE="GNU-AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S="${PN}-src-r${PV}"

RDEPEND="
	dev-libs/pcre++
	dev-lang/spidermonkey
"
DEPEND="
	>=dev-util/scons-1.2.0-r1
	app-shells/tcsh
	dev-libs/boost
	${RDEPEND}
"

# todo: find a way to automate this
S="${WORKDIR}/mongodb-mongo-75a58367af664525db5e7226db81082be19e4f06"

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb
}

src_compile() {
	# we do not use MAKEOPTS here. tested here with -j7 and 2GB ram wasn't
	# enough
	scons all || die "scons failed"
}

src_install() {
	# dirty hack as it seems DESTDIR="${D}" doesn't work
	scons --prefix="${D}/usr" install || die "scons install failed"

	for x in /var/{lib,log,run}/${PN}; do
		dodir "${x}" || die "Install failed"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1 || die "Install failed"

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die "Install failed"
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die "Install failed"

	dodoc README
}

