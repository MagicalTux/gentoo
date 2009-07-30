# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git php-ext-pecl-r1

DESCRIPTION="Mongo (from "humongous") is a high-performance, open source, schema-free document-oriented  database."
HOMEPAGE="http://www.mongodb.org/display/DOCS/PHP+Language+Center"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-db/mongo"
DEPEND="${RDEPEND}"

EGIT_REPO_URI="git://github.com/mongodb/mongo-php-driver.git"

PHP_EXT_NAME="mongo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

need_php_by_category

