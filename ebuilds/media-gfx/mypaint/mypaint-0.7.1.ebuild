# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="MyPaint is a fast and easy open-source graphics application for digital painters."
HOMEPAGE="http://mypaint.intilinux.com/"
SRC_URI="http://download.gna.org/mypaint/mypaint-0.7.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-python/pygtk
	dev-lang/python
	dev-libs/glib
"
DEPEND="
	${RDEPEND}
	dev-lang/swig
	dev-util/scons
"

src_compile() {
	scons ${MAKEOPTS} || die "scons make failed"
}

src_install() {
	scons install DESTDIR="${D}" || die "scons install failed"
}

