# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="doc source"

inherit subversion

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

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

EANT_BUILD_TARGET=""
EANT_DOC_TARGET=""

src_prepare() {
	./boostrap.sh
}

src_configure() {
# TODO: handle useflags
	econf
}

src_install() {
	make install
}

