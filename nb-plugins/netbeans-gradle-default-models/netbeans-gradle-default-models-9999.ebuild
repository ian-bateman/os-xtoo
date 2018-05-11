# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="netbeans-gradle-project"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/kelemen/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="NetBeans plugin able to open Gradle based Java projects"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

GRADLE_SLOT="0"

CP_DEPEND="
	dev-java/gradle-base-services:${GRADLE_SLOT}
	dev-java/gradle-tooling-api:${GRADLE_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"
