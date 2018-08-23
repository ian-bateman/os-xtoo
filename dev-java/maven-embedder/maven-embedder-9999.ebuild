# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://repo1.maven.org/maven2/org/apache/${MY_PN}/${PN}/${PV}/${P}-sources.jar"
#	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"
MR_SLOT="0"
PC_SLOT="0"
SLF4J_SLOT="0"

CP_DEPEND="
	dev-java/commons-cli:1
	dev-java/commons-lang:3
	dev-java/guice:4
	dev-java/javax-inject:0
	dev-java/logback-core:0
	~dev-java/maven-artifact-${PV}:${SLOT}
	~dev-java/maven-builder-support-${PV}:${SLOT}
	~dev-java/maven-core-${PV}:${SLOT}
	~dev-java/maven-model-${PV}:${SLOT}
	~dev-java/maven-model-builder-${PV}:${SLOT}
	~dev-java/maven-plugin-api-${PV}:${SLOT}
	dev-java/maven-resolver-api:${MR_SLOT}
	dev-java/maven-resolver-util:${MR_SLOT}
	~dev-java/maven-settings-${PV}:${SLOT}
	~dev-java/maven-settings-builder-${PV}:${SLOT}
	~dev-java/maven-slf4j-provider-${PV}:${SLOT}
	dev-java/maven-shared-utils:0
	dev-java/plexus-classworlds:0
	dev-java/plexus-cipher:0
	dev-java/plexus-component-annotations:${PC_SLOT}
	dev-java/plexus-sec-dispatcher:0
	dev-java/plexus-utils:0
	dev-java/sisu-plexus:0
	dev-java/slf4j-api:${SLF4J_SLOT}
	dev-java/slf4j-simple:${SLF4J_SLOT}
"

inherit java-pkg

DESCRIPTION="Build automation tool used primarily for Java projects"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/modello-plugin-java:0"

#S="${WORKDIR}/${MY_S}/${PN}"

# Till packaged
JAVA_RM_FILES=( org/apache/maven/cli/logging/impl/LogbackConfiguration.java )
