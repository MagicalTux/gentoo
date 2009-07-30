# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc source"

inherit subversion java-pkg-opt-2

DESCRIPTION="Thrift is a software framework for scalable cross-language services development"
HOMEPAGE="http://incubator.apache.org/thrift/"
SRC_URI=""

ESVN_REPO_URI="http://svn.apache.org/repos/asf/incubator/thrift/trunk"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="java php cpp csharp python ruby perl erlang cocao smalltalk ocaml haskell
xsd html"

COMMON_DEP="dev-libs/boost"

RDEPEND="java? ( >=virtual/jre-1.4 )
	${COMMON_DEP}"
DEPEND="java? ( >=virtual/jdk-1.4 )
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

src_prepare() {
	./boostrap.sh
}

src_configure() {
	local myconf=""
	if use java; then
		myconf="${myconf} --enable-gen-java --with-java --with-javac-args=\"$(java-pkg_javac-args)\""
	else
		myconf="${myconf} --disable-gen-java --without-java"
	fi
# TODO: handle useflags
	econf ${myconf}
}

src_install() {
	make install DESTDIR=${D} || die

	if use java; then
		java-pkg_newjar lib/java/libthrift.jar libthrift.jar
	fi
}

