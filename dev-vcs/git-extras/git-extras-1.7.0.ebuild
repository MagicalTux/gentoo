# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Little git extras"
HOMEPAGE="https://github.com/visionmedia/git-extras"
SRC_URI="https://github.com/visionmedia/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/git"
RDEPEND="${DEPEND}"

src_compile() {
	# nothing to do
	:
}

src_install() {
	emake install DESTDIR="${D}"
}

