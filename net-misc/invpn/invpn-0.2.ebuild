# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit qt4-r2

DESCRIPTION="invpn is a decentralized secure VPN server"
HOMEPAGE="https://github.com/MagicalTux/invpn"
SRC_URI="http://cloud.github.com/downloads/MagicalTux/invpn/invpn-0.2.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="x11-libs/qt-core:4"
RDEPEND="${DEPEND}"

DOCS="ChangeLog README.md"

