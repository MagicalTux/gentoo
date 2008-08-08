# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

DESCRIPTION="Provides a generic and flexible way to access and interact with USB HID devices"
HOMEPAGE="http://libhid.alioth.debian.org/"
SRC_URI="http://beta.magicaltux.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc python"

DEPEND="dev-libs/libusb
	doc? ( app-doc/doxygen )
	python? ( dev-lang/swig )"
RDEPEND="dev-libs/libusb"

src_compile() {
	local myconf

	if use doc; then
		myconf="$myconf --with-doxygen"
	else
		myconf="$myconf --without-doxygen"
	fi

	econf $(use_enable python swig) ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README README.licence TODO || die
	if use doc; then
		dohtml doc/www/*
	fi
#	dohtml EXTENDING.html ctags.html
}

