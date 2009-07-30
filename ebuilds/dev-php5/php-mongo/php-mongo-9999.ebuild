# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

EGIT_REPO_URI="git://github.com/mongodb/mongo-php-driver.git"

PHP_EXT_NAME="mongo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1 git

DESCRIPTION="Mongo (from \"humongous\") is a high-performance, open source, schema-free document-oriented  database."
HOMEPAGE="http://www.mongodb.org/display/DOCS/PHP+Language+Center"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-db/mongodb"
DEPEND="${RDEPEND}"

need_php_by_category

src_unpack() {
	# we override src_unpack as both git and php-ext-pecl-r1 are trying to take
	# it over
	git_src_unpack
	# can't call php-ext-source-r1_src_unpack directly as it tries to unpack
	# "${A}" which is empty
	cd "${S}"
	php-ext-source-r1_phpize
}

