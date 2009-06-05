# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Google depot_tools for building google stuff"
HOMEPAGE="http://dev.chromium.org/developers/how-tos/install-gclient"
SRC_URI="http://src.chromium.org/svn/trunk/tools/depot_tools.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}"

src_install() {
	# this will naturally avoid copying ".svn"
	mkdir -p /opt/google/depot_tools/
	cp -R depot_tools/* /opt/google/depot_tools/
}


