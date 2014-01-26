# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DB_VER="4.7"

inherit eutils qt4-r2 db-use

DESCRIPTION="A peer-to-peer network based digital currency."
HOMEPAGE="http://bitcoin.org/"
SRC_URI="mirror://sourceforge/bitcoin/${P}-linux.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls getblock qt qrencode dbus upnp debug ssl"

RDEPEND="
	qrencode? ( media-gfx/qrencode )
	qt? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
	dbus? ( dev-qt/qtdbus:4 )
	upnp? ( net-libs/miniupnpc )
	dev-libs/openssl
	dev-libs/boost
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-linux"

pkg_setup() {
	# Used by daemon
	ebegin "Creating bitcoin user and group"
	enewgroup bitcoin
	enewuser bitcoin -1 -1 /var/lib/bitcoin bitcoin
}

src_prepare() {
	if use getblock; then
		epatch "${FILESDIR}/${P}-getblock.patch"
	fi
	if use qt; then
		cd "${S}/src"
		eqmake4 "${S}/src/bitcoin-qt.pro" RELEASE=1 \
			$(use dbus && echo "USE_DBUS=1") $(use qrencode && echo "USE_QRCODE=1") \
			$( use upnp || echo "USE_UPNP=-" ) USE_SSL=1
		emake -f makefile.unix bitcoin USE_WX=1 || die "Failed to compile"
	fi
}

src_compile() {
	# Override MAKEOPTS to avoid killing compiling host
	MAKEOPTS="-j1"
	if use qt; then
		cd "${S}/src"
		emake || die "Failed to compile"
	fi
	cd "${S}/src/src"
	local OPTS=()
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	local BOOST_PKG BOOST_VER BOOST_INC
	BOOST_PKG="$(best_version 'dev-libs/boost')"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	OPTS+=("BOOST_INCLUDE_PATH=${BOOST_INC}")
	OPTS+=("BOOST_LIB_SUFFIX=-${BOOST_VER}")

	use ssl  && OPTS+=(USE_SSL=1)

	if use upnp; then
		OPTS+=(USE_UPNP=1)
	else
		OPTS+=(USE_UPNP=)
	fi

	emake -f makefile.unix "${OPTS[@]}" bitcoind || die "Failed to compile"
}

src_install() {
	if use qt; then
		cd "${S}/src"
		dobin bitcoin-qt
		insinto /usr/share/pixmaps
		doins "${S}/src/share/pixmaps/bitcoin.ico"
		make_desktop_entry bitcoin-qt "Bitcoin" "/usr/share/pixmaps/bitcoin.ico" "Network;P2P"
	fi

	cd "${S}/src/src"
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

	cd "${S}/src/doc"
	# Documentation: change to unix line end and install.
	edos2unix *.txt
	dodoc *.txt
}
