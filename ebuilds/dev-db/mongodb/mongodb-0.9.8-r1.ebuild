# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Mongo (from \"humongous\") is a high-performance, open source, schema-free document-oriented  database."
HOMEPAGE="http://www.mongodb.org/"
SRC_URI=""

EGIT_REPO_URI="git://github.com/mongodb/mongo.git"
EGIT_BRANCH="r${PV}"

inherit git

LICENSE="GNU-AGPL-3.0"
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

src_compile() {
	# we do not use MAKEOPTS here. tested here with -j7 and 2GB ram wasn't
	# enough
	scons all || die "scons failed"
}

src_install() {
	# dirty hack as it seems DESTDIR="${D}" doesn't work
	scons --prefix="${D}/usr" install || die "scons install failed"
	dodoc README
}

