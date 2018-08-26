# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/releases/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_PN}-releases-${PV}"
fi

CP_DEPEND="
	dev-java/guice:4
	dev-java/javax-inject:0
	dev-java/osgi-core-api:7
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:0
	dev-java/plexus-utils:0
	dev-java/sisu-inject:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="Modular JSR330-based container"
HOMEPAGE="https://www.eclipse.org/sisu/"
LICENSE="EPL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/org.eclipse.${MY_PN}"

JAVA_RES_DIR="resources"
JAVA_RM_FILES=( src/org/codehaus/plexus/PlexusTestCase.java )

java_prepare() {
	mkdir resources || die "Failed to make resources directory"
	mv META-INF resources || die "Failed to move resources into directory"
}
