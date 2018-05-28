# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="dev-java/ant-core:0"

inherit java-pkg

DESCRIPTION="Space efficient annotation indexer and offline reflection library"

MY_PN="wildfly"
MY_PV="${PV}.Final"
MY_P="${PN}-${MY_PV}"

HOMEPAGE="https://github.com/${MY_PN}/${PN}"
SRC_URI="${HOMEPAGE}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_P}"
