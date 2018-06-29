# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/takari/${MY_PN}-maven"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-maven-${MY_P}"
fi

SLOT="0"
MAVEN_SLOT="0"

CP_DEPEND="
	dev-java/groovy:0
	dev-java/maven-model:${MAVEN_SLOT}
	dev-java/maven-model-builder:${MAVEN_SLOT}
	dev-java/plexus-component-annotations:0
	dev-java/plexus-utils:0
	~dev-java/polyglot-common-${PV}:${SLOT}
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/${PN}"
