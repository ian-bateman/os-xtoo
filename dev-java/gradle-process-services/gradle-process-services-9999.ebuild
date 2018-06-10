# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="gradle"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/native-platform:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	dev-java/guava:25
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://gradle.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN#*-}"
