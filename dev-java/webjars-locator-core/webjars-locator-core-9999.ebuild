# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:7}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/commons-compress:0
	dev-java/commons-lang:3
	dev-java/jackson-core:2
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Provides a means to locate assets within WebJars"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"
