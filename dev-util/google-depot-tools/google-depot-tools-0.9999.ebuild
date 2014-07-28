# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

DESCRIPTION="Chromium and other Google projects sometimes uses a package of scripts, the depot_tools, to manage interaction with the source code repository and the project's development process."
HOMEPAGE="http://dev.chromium.org/developers/how-tos/install-depot-tools"
EGIT_REPO_URI="https://chromium.googlesource.com/chromium/tools/depot_tools.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}"

src_install() {
	# this will naturally avoid copying ".svn"
	dodoc LICENSE README README.gclient README.codereview README.git-cl README.testing
	mkdir -p "${D}/opt/google/"
	cp -R "${S}/" "${D}/opt/google/depot_tools/" || die "Install failed!"
}

