# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="spring-framework"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/spring-projects/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.RELEASE.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}/${PN}"
fi

inherit java-pkg

DESCRIPTION="Spring Framework ${PN:7}"
HOMEPAGE="https://spring.io/"
LICENSE="Apache-2.0"
SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	dev-java/cglib:3
	dev-java/commons-logging:0
	dev-java/javax-inject:0
	dev-java/snakeyaml:0
	~dev-java/spring-core-${PV}:${SLOT}
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-10"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-10"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	cd src/main/java/org/springframework/beans/factory || die "cd failed"

	# Replaced repackaged with standard
	sed -i -e "s|org.springframework.cg|net.sf.cg|g" \
		support/CglibSubclassingInstantiationStrategy.java \
		|| die "Could not sed cglib"
	# Reverse one import change, crude
	sed -i -e "s|net.sf.cglib.core.SpringNamingPolicy|org.springframework.cglib.core.SpringNamingPolicy|g" \
		support/CglibSubclassingInstantiationStrategy.java \
		|| die "Could not sed cglib"
	# update per changes in snakeyaml
	sed -i -e "s| createDefaultMap()| createDefaultMap(int initSize)|" \
		-e "s|.createDefaultMap()|.createDefaultMap(initSize)|" \
		config/YamlProcessor.java \
		|| die "Failed to sed/update snakeyaml changes"
}
