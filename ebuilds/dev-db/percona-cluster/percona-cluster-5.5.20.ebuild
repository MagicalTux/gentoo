# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Percona XtraDB cluster"
HOMEPAGE="http://www.percona.com/software/percona-xtradb-cluster/"
SRC_URI="http://www.percona.com/downloads/Percona-XtraDB-Cluster/${PV}-23.4/source/percona-xtradb-cluster-galera.tar.gz
	http://www.percona.com/downloads/Percona-XtraDB-Cluster/${PV}-23.4/source/percona-xtradb-cluster-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/scons"
RDEPEND="${DEPEND} net-analyzer/netcat dev-libs/boost dev-libs/check"

S="${WORKDIR}/percona-xtradb-cluster-galera"

src_prepare() {
	epatch "${FILESDIR}/percona-cluster-5.5.20-remove_svnversion_calls.patch"
}

src_compile() {
#	scons || die "scons failed"
	MYSQL_SRC="${WORKDIR}/percona-xtradb-cluster-${PV}" ./scripts/mysql/build.sh -b \
		-s -o -t
}

src_install() {
	mkdir -p "${D}/opt/percona-cluster"
	tar -xv -C "${D}/opt/percona-cluster" --strip-components 1 -f "${S}/scripts/mysql/mysql-${PV}-XXXX,xxxx.tgz"
}

