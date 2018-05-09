# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="logging"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN%*-*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P%*-*-*}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN%*-*}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="An ultra-thin bridge between different Java logging libraries - Adapters"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/avalon-logkit:0
	~dev-java/commons-logging-${PV}:${SLOT}
	dev-java/log4j:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# Remove classes that go in commons-logging
	cd "${S}/src/main/java/org/apache/commons/logging/" \
		|| die "Failed to change to directory"
	rm *.java impl/Aval* impl/Jdk14* impl/LogF* impl/No* impl/Weak* \
		|| die "Failed to remove commons-logging sources"
}
