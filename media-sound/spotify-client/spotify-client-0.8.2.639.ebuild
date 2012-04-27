# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PV="${PV}.g79d339d.504-1"

DESCRIPTION="Spotify client for Gentoo"
HOMEPAGE="http://www.spotify.com/"
SRC_URI="http://repository.spotify.com/pool/non-free/s/spotify/spotify-client-qt_${MY_PV}_all.deb
	amd64? (
		http://repository.spotify.com/pool/non-free/s/spotify/spotify-client_${MY_PV}_amd64.deb
	)
	x86? (
		http://repository.spotify.com/pool/non-free/s/spotify/spotify-client_${MY_PV}_i386.deb
	)"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} media-sound/pulseaudio"

src_unpack() {
	mkdir "${S}"
	cd "${S}"
	ar x "${DISTDIR}/spotify-client-qt_${MY_PV}_all.deb"
	tar xzf "${S}/data.tar.gz"
	if use amd64; then
		ar x "${DISTDIR}/spotify-client_${MY_PV}_amd64.deb"
	fi
	if use x86; then
		ar x "${DISTDIR}/spotify-client_${MY_PV}_i386.deb"
	fi
	tar xzf "${S}/data.tar.gz"
	rm -f data.taz.gz control.tar.gz debian-binary
}
src_configure() {
	return
}
src_compile() {
	# patch spotify to not depend on lib versions
	for foo in libcrypto.so libssl.so; do
		sed -i -e "s/$foo./$foo\x00/" "usr/bin/spotify"
		sed -i -e "s/$foo./$foo\x00/" "usr/share/spotify/spotify"
	done
	for foo in libcrypto.so libssl.so libnss3.so libnssutil3.so libsmime3.so libplc4.so libnspr4.so; do
		sed -i -e "s/$foo./$foo\x00/" "usr/share/spotify/libcef.so"
	done
	sed -i -e "s/libpng12.so/libpng.so\x00\x00/" "usr/share/spotify/libcef.so"
}
src_install() {
	cp -r "usr" "${D}/"
}

