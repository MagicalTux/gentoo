# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit git-2

DESCRIPTION="Chromium and other Google projects sometimes uses a package of scripts, the depot_tools, to manage interaction with the source code repository and the project's development process."
HOMEPAGE="http://dev.chromium.org/developers/how-tos/install-depot-tools"
EGIT_REPO_URI="https://chromium.googlesource.com/chromium/tools/depot_tools.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/python:2.7"
DEPEND="${RDEPEND}"

src_install() {
	# point to python2 rather than python
	sed -i 's/ exec python / exec python2 /' download_from_google_storage fetch gcl clang-format roll-dep apply_issue drover gclient git-runhooks gn

	# empty update_depot_tools as upgrades are to be handled by emerge
	echo '#!/bin/sh' >update_depot_tools
	echo 'exit' >>update_depot_tools
	chmod +x update_depot_tools

	dodoc LICENSE README README.gclient README.codereview README.git-cl README.testing
	mkdir -p "${D}/opt/google/depot_tools/"
	# this will naturally avoid copying ".git" and ".gitignore"
	cp -R "${S}/"* "${D}/opt/google/depot_tools/" || die "Install failed!"
}

