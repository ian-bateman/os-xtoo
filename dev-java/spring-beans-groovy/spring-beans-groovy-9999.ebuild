# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

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
	dev-java/commons-logging:0
	dev-java/groovy:0
	dev-java/groovy-xml:0
	~dev-java/spring-beans-${PV}:${SLOT}
	~dev-java/spring-core-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"

# ugly
src_compile() {
	# compile dep/boostrap class :(
	local my_class
	my_class="${S}/${JAVA_SRC_DIR}/org/springframework/beans/factory/groovy/GroovyBeanDefinitionWrapper"
	ejavac -cp $(java-pkg_getjars groovy,spring-beans-${SLOT},spring-core-${SLOT}) \
		"${my_class}.java" || die "javac ${my_class}.java failed"

	# compile groovy
	local classes my_file
	classes=groovy_target/groovy_classes
	my_file="${S}/src/main/groovy/org/springframework/beans/factory/groovy/GroovyDynamicElementReader"
	groovyc -d "${S}/${classes}" \
		-cp "${S}/${JAVA_SRC_DIR}:$(java-pkg_getjars commons-logging,groovy-xml,spring-beans-${SLOT},spring-core-${SLOT})" \
		"${my_file}.groovy" || die "groovyc failed"

	# compile java update jar
	JAVA_CLASSPATH_EXTRA="${S}/${classes}"
	java-pkg-simple_src_compile
	jar uf ${PN}.jar -C "${classes}" . || die "update jar failed"
}
