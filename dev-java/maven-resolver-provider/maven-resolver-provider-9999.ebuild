# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"

AETHER_SLOT="0"

CP_DEPEND="
	dev-java/aether-api:${AETHER_SLOT}
	dev-java/aether-impl:${AETHER_SLOT}
	dev-java/aether-spi:${AETHER_SLOT}
	dev-java/aether-util:${AETHER_SLOT}
	dev-java/commons-lang:3
	dev-java/javax-inject:0
	dev-java/guice:4
	~dev-java/maven-builder-support-${PV}:${SLOT}
	~dev-java/maven-model-${PV}:${SLOT}
	~dev-java/maven-model-builder-${PV}:${SLOT}
	~dev-java/maven-repository-metadata-${PV}:${SLOT}
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
