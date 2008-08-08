# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Provides a generic and flexible way to access and interact with USB HID devices"
HOMEPAGE="http://libhid.alioth.debian.org/"
SRC_URI="http://beta.magicaltux.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="dev-libs/libusb
	python? ( dev-lang/swig )"
RDEPEND="dev-libs/libusb"

src_compile() {
	econf $(use_enable python swig) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README README.licence TODO || die
#	dohtml EXTENDING.html ctags.html
}

