# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

WX_GTK_VER="2.9"

inherit distutils eutils wxwidgets

DESCRIPTION="A peer-to-peer network based digital currency."
HOMEPAGE="http://bitcoin.org/"
SRC_URI="mirror://sourceforge/bitcoin/${P}-linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wxwidgets nls sse2 getblock"

RDEPEND="
	wxwidgets? ( x11-libs/wxGTK:2.9[X] >=app-admin/eselect-wxwidgets-0.7-r1 )
	dev-libs/crypto++
	dev-libs/openssl
	dev-libs/boost
	sys-libs/db:4.7
"
DEPEND="${RDEPEND}"

pkg_setup() {
	# Used by daemon
	ebegin "Creating bitcoin user and group"
	enewgroup bitcoin
	enewuser bitcoin -1 -1 /var/lib/bitcoin bitcoin
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gentoo.patch"
	if use getblock; then
		# stupid patch needs to be applied from src dir
		cd "${S}/src"
		edos2unix rpc.cpp
		epatch "${FILESDIR}/${P}-getblock.patch"
		cd "${S}"
	fi
	if ! use sse2; then
		sed -i 's/-DFOURWAYSSE2//' "${S}/src/makefile.unix"
	fi
}

src_compile() {
	# Override MAKEOPTS to avoid killing compiling host
	MAKEOPTS="-j1"
	cd "${S}/src"
	if use wxwidgets; then
		emake -f makefile.unix bitcoin USE_WX=1
	fi
	emake -f makefile.unix bitcoind
}

src_install() {
	cd "${S}/src"
	if use wxwidgets; then
		dobin bitcoin
		insinto /usr/share/pixmaps
		cd "${S}/src/rc"
		doins bitcoin.ico
		make_desktop_entry ${PN} "Bitcoin" "/usr/share/pixmaps/bitcoin.ico" "Network;P2P"
		cd "${S}/src"
	fi

	dobin bitcoind
	insinto /etc/bitcoin
	# RPC configuration (user and password).
	newins "${FILESDIR}/bitcoin.conf" bitcoin.conf
	# For daemons eyes only.
	fowners bitcoin:bitcoin /etc/bitcoin/bitcoin.conf
	fperms 600 /etc/bitcoin/bitcoin.conf
	# Init script and configuration
	newconfd "${FILESDIR}/bitcoin.confd" bitcoin
	newinitd "${FILESDIR}/bitcoin.initd" bitcoin
	# Bitcoinds home dir, restrict to that user only.
	# Contains wallet.dat and we don't want other users stealing it.
	diropts -m700
	dodir /var/lib/bitcoin
	fowners bitcoin:bitcoin /var/lib/bitcoin
	# To stop bitcoind we need the symlink (su doesn't let bitcoind know about /etc/bitcoin/bitcoin.conf).
	dodir /var/lib/bitcoin/.bitcoin
	fowners bitcoin:bitcoin /var/lib/bitcoin/.bitcoin
	dosym /etc/bitcoin/bitcoin.conf /var/lib/bitcoin/.bitcoin/bitcoin.conf

	cd "${S}/locale/"
	if use nls; then
		# Check what LINGUAS are set and install the language files if they
		# exsist.
		einfo "Installing language files"
		for val in ${LINGUAS}
		do
			if [ -e "$val/LC_MESSAGES/bitcoin.mo" ]; then
				einfo "$val"
				insinto "/usr/share/locale/$val/LC_MESSAGES/"
				doins "$val/LC_MESSAGES/bitcoin.mo"
			fi
		done
	fi

	cd "${S}"
	# Documentation: change to unix line end and install.
	edos2unix *.txt
	dodoc *.txt
}
