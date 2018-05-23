# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN#*-}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

SPRING_SLOT="4.3"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-codec:0
	dev-java/commons-jexl:2
	dev-java/commons-jxpath:0
	dev-java/commons-lang:3
	dev-java/commons-logging:0
	dev-java/commons-vfs:2
	dev-java/spring-beans:${SPRING_SLOT}
	dev-java/spring-core:${SPRING_SLOT}
	dev-java/xml-commons-resolver:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Generic interface to read configuration data from a variety of sources"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

JDK_VERSION="1.8"

DEPEND+="dev-java/javacc:0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	javacc -JDK_VERSION="${JDK_VERSION}" \
		-OUTPUT_DIRECTORY="${S}/src/main/java" \
		"${S}/src/main/javacc/PropertyListParser.jj" \
		|| die "javacc PropertyListParser.jj failed"
}
