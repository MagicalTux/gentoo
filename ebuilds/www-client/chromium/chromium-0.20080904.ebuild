# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Chromium is an open-source browser project that aims to build a
safer, faster, and more stable way for all Internet users to experience the web."
HOMEPAGE="http://dev.chromium.org/"
SRC_URI="http://build.chromium.org/buildbot/archives/chromium.tgz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
  >=dev-lang/python-2.4
  >=dev-lang/perl-5
  >=sys-devel/gcc-4.2
  >=dev-libs/nss-3.12
"
DEPEND="${RDEPEND}
  >=dev-util/pkgconfig-0.20
  >=sys-devel/bison-2.3
  >=sys-devel/flex-2.5.34
  >=dev-util/gperf-3.0.3
"

src_compile() {
	cd src/chrome
	../third_party/scons/scons.py Hammer
}

src_install() {
	die "todo me!"
}

