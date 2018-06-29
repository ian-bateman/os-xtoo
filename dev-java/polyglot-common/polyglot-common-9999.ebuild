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
PC_SLOT="0"

CP_DEPEND="
	dev-java/maven-core:${MAVEN_SLOT}
	dev-java/maven-builder-support:${MAVEN_SLOT}
	dev-java/maven-model:${MAVEN_SLOT}
	dev-java/maven-model-builder:${MAVEN_SLOT}
	dev-java/maven-plugin-api:${MAVEN_SLOT}
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:${PC_SLOT}
	dev-java/plexus-container-default:${PC_SLOT}
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/${PN}"
