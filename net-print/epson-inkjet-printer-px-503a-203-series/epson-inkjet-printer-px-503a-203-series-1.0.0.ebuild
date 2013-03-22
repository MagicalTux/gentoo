# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit rpm autotools base

DESCRIPTION="Epson Inkjet Printer Driver (ESC/P-R), supports various pinters"
HOMEPAGE="http://avasys.jp/eng/linux_driver/download/lsb/epson-inkjet/escpr/"
SRC_URI="http://a1227.g.akamai.net/f/1227/40484/1d/download.ebz.epson.net/dsc/f/01/00/01/68/58/fec96a06b86aa537622cbc9c72b2eacf0a6e01f5/${P}-1lsb3.2.src.rpm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"

S="${WORKDIR}/epson-inkjet-printer-filter-${PV}"

src_unpack() {
	rpm_src_unpack
}

src_prepare() {
	eautoreconf
	chmod +x configure
}

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake -j1 || die
}
