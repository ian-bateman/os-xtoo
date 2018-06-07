# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jdk"
MY_PV="${PV/_pre/+}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javafxports/openjdk-jfx"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="openjdk-jfx-${MY_P/+/-}"
fi

inherit java-pkg

DESCRIPTION="JavaFX Base"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}/modules/${PN/-/.}"

java_prepare() {
	sed -e "s|@BUILD_TIMESTAMP@|$(date +%Y%m%d%H%M%S)|" \
		-e "s|@HUDSON_JOB_NAME@|os-xtoo|" \
		-e "s|@HUDSON_BUILD_NUMBER@|${PV}|" \
		-e "s|@PROMOTED_BUILD_NUMBER@|${PV}|" \
		-e "s|@RELEASE_VERSION@|${PV}|" \
		-e "s|@RELEASE_SUFFIX@|os-xtoo|" \
		src/main/version-info/VersionInfo.java > \
		src/main/java/VersionInfo.java \
		|| die "Failed to sed/remove mia exported package"
}
