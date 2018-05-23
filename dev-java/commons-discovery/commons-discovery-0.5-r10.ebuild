# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="dev-java/commons-logging:0"

inherit java-pkg

DESCRIPTION="Commons Discovery: Service Discovery component"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
SRC_URI="mirror://apache/${PN/-///}/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${P}-src"
