# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN%%-*}"
MY_P="apache-${MY_PN}-${PV}-src"

inherit java-pkg

DESCRIPTION="EOL Tomcat's Servlet API"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="https://archive.apache.org/dist/${MY_PN}/${MY_PN}-${PV%%.*}/v${PV}/src/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

case ${PV%%.*} in
	5) SLOT="2.4" ;;
	4) SLOT="2.3" ;;
esac

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	local p

	mkdir -p resources/javax/serlvet/resources \
		|| die "Failed to make directory"

	if [[ ${SLOT} == 2.4 ]]; then
		p="jsr154/"
		mv servletapi/jsr152/src/share/javax/servlet/{jsp/el,} \
			|| die "Failed to move el classes"
	fi

	mv servletapi/${p/4/2}src/share/javax/{servlet/jsp,} \
		|| die "Failed to move jsp classes"

	mv servletapi/${p}src/share/dtd/* resources/javax/serlvet/resources \
		|| die "Failed to move jsp-api/servlet-api resources"
}

src_compile() {
	local p

	if [[ ${SLOT} == "2.4" ]]; then
		JAVA_JAR_FILENAME="el-api.jar"
		JAVA_SRC_DIR="servletapi/jsr152/src/share/javax/servlet/el"
		java-pkg-simple_src_compile

		JAVA_CLASSPATH_EXTRA="${S}/el-api.jar:"
		p="jsr154/"
	fi

	JAVA_JAR_FILENAME="servlet-api.jar"
	JAVA_SRC_DIR="servletapi/${p}src/share/javax/servlet"
	JAVA_RES_DIR="resources"
	java-pkg-simple_src_compile

	JAVA_CLASSPATH_EXTRA+="${S}/servlet-api.jar"
	JAVA_JAR_FILENAME="jsp-api.jar"
	JAVA_SRC_DIR="servletapi/${p/4/2}src/share/javax/jsp"
	JAVA_RES_DIR="resources"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar "${S}/"*-api.jar
}
