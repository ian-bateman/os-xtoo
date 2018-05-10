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
	dev-java/aspectj:0
	dev-java/cglib:3
	dev-java/commons-codec:0
	dev-java/commons-logging:0
	dev-java/jaxb-api:0
	dev-java/jopt-simple:0
	dev-java/log4j:0
	dev-java/objenesis:2
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# Replaced repackaged with standard
	sed -i -e "s|g.springframework.o|g.o|g" \
		"${S}/${JAVA_SRC_DIR}/org/springframework/objenesis/SpringObjenesis.java" \
		|| die "Could not sed objenesis"

	# Add missing import
	sed -i -e '18iimport net.sf.cglib.core.DefaultNamingPolicy;' \
		"${S}/${JAVA_SRC_DIR}/org/springframework/cglib/core/SpringNamingPolicy.java" \
		|| die "Could not sed objenesis"
}
