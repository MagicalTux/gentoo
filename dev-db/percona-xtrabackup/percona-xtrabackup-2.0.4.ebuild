# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Open source hot backup tool for InnoDB and XtraDB databases"
HOMEPAGE="https://launchpad.net/percona-xtrabackup"
SRC_URI="http://s3.amazonaws.com/percona.com/downloads/community/mysql-5.1.59.tar.gz"
EBZR_REPO_URI="lp:percona-xtrabackup/2.0"
EBZR_BRANCH="2.0"
EBZR_REVISION="484" # 2.0.4 (2012-12-03)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	bzr_src_unpack
	# copy mysql in root
	cp "${DISTDIR}/mysql-5.1.59.tar.gz" "${S}/percona-server-5.1-xtrabackup"
}

src_configure() {
	return
}

src_compile() {
	# This will use bzr to fetch stuff too, not really nice but too lazy to fix
	# that at this point
	# At least, it works
	./utils/build.sh xtradb
}

src_install() {
	cp "${S}/innobackupex" "${D}/usr/bin"
	dodoc COPYING
	doman doc/xtrabackup.1
	dobin innobackupex
	dobin src/xtrabackup
	dobin src/xbstream
}

