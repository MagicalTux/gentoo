# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit cmake-utils

DESCRIPTION="libgit2 is a portable, pure C implementation of the Git core
methods provided as a re-entrant linkable library with a solid API, allowing you
to write native speed custom Git applications in any language which supports C
bindings."
HOMEPAGE="http://libgit2.github.com/"
SRC_URI="https://github.com/downloads/libgit2/libgit2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

