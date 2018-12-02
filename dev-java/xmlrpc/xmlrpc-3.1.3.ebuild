# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source test"

BASE_URI="https://archive.apache.org/dist/ws/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/apache-${P}-src.tar.bz2"
	MY_S="apache-${P}-src"
fi

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/commons-httpclient:0
	dev-java/commons-codec:0
	dev-java/ws-commons-util:0
	dev-java/commons-logging:0
	java-virtuals/servlet-api:2.4
	dev-java/junit:4
"

inherit java-pkg

DESCRIPTION="Apache XML-RPC is a Java implementation of XML-RPC"
HOMEPAGE="http://ws.apache.org/xmlrpc/"
LICENSE="Apache-2.0"
SLOT="3.1"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/jdk-9
	test? (
		dev-java/ant-junit:0
	)
	${CP_DEPEND}"

RDEPEND=">=virtual/jre-9
	${CP_DEPEND}"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# Doesn't work.
	rm -v \
		server/src/test/java/org/apache/xmlrpc/test/SerializerTest.java
}

src_compile() {
	JAVA_JAR_FILENAME="${S}/${PN}-common.jar"
	JAVA_SRC_DIR="common/src"
	java-pkg-simple_src_compile

	JAVA_CLASSPATH_EXTRA="${S}/${PN}-common.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-client.jar"
	JAVA_SRC_DIR="client/src"
	JAVA_RES_DIR="${S}/src/main/resources/client"
	java-pkg-simple_src_compile

	JAVA_CLASSPATH_EXTRA="${S}/${PN}-common.jar:${S}/${PN}-client.jar"
	JAVA_JAR_FILENAME="${S}/${PN}-server.jar"
	JAVA_SRC_DIR="server/src"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg_dojar xmlrpc-common.jar xmlrpc-server.jar xmlrpc-client.jar

	use doc && java-pkg_dojavadoc {common,server,client}/target/site/apidocs
	use source && java-pkg_dosrc {common,server,client}/src/main/java/*
}
