# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Mongo (from \"humongous\") is a high-performance, open source, schema-free document-oriented  database."
HOMEPAGE="http://www.mongodb.org/"
SRC_URI="http://github.com/mongodb/mongo/tarball/r${PV} -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/pcre++
	dev-lang/spidermonkey
"
DEPEND="
	dev-util/scons
	app-shells/tcsh
	dev-libs/boost
	${RDEPEND}
"

src_unpack() {
	unpack ${A}
	ls
	for foo in mongodb-mongo-*; do S="${foo}"; done
}

src_compile() {
	scons all
}

src_install() {
	scons --prefix=${D} install
}

