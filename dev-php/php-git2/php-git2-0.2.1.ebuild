# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit git-2

DESCRIPTION="PHP bindings for libgit2"
HOMEPAGE="https://github.com/libgit2/php-git"
PHP_EXT_NAME="git2"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README.md"

USE_PHP="php5-3 php5-4"

inherit php-ext-source-r2

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/libgit2/php-git.git"
	inherit git-2
else
	inherit vcs-snapshot
	SRC_URI="https://github.com/libgit2/php-git/tarball/v${PV} -> ${P}-src.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="<=dev-libs/libgit2-0.16.0"
RDEPEND="${DEPEND}"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		vcs-snapshot_src_unpack
	fi
	mv "${S}/src"/* "${S}"
}

