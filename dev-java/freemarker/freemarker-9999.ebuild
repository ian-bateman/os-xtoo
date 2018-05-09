# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="incubator-${PN}"
MY_PV="${PV/_pre/-gae}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A Java tool to generate text output based on templates"
HOMEPAGE="https://freemarker.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

#	dev-java/jdom:2
CP_DEPEND="
	dev-java/ant-core:0
	dev-java/avalon-logkit:0
	dev-java/commons-logging:0
	dev-java/dom4j:2
	dev-java/jaxen:0
	dev-java/jython:2.7
	dev-java/log4j:0
	dev-java/rhino:0
	dev-java/slf4j-api:0
	dev-java/spotbugs-annotations:0
	dev-java/xalan:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	dev-java/javacc
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/"

#PATCHES=( "${FILESDIR}/jdom2.patch" )

JAVAC_ARGS="--add-modules java.xml "
JAVAC_ARGS+="--add-exports=java.xml/com.sun.org.apache.xml.internal.utils=ALL-UNNAMED "
JAVAC_ARGS+="--add-exports=java.xml/com.sun.org.apache.xpath.internal=ALL-UNNAMED "
JAVAC_ARGS+="--add-exports=java.xml/com.sun.org.apache.xpath.internal.objects=ALL-UNNAMED "

java_prepare() {
	# need to package jrebel?
	rm src/main/java/freemarker/ext/beans/JRebelClassChangeNotifier.java \
		|| die "Failed to remove JRebelClassChangeNotifier.java"

	# fix javacc keyword
	sed -i -e "s|template|TOKEN_TEMPLATE|g" \
		-e '901i    <TOKEN_TEMPLATE: "template" }>' \
		-e '902i    |' \
		src/main/javacc/FTL.jj \
		|| die "Failed to sed FTL.jj keyword template for javacc"

	javacc -JDK_VERSION="1.9" \
		-OUTPUT_DIRECTORY=src/main/java/freemarker/core \
		src/main/javacc/FTL.jj \
		|| die "Failed javacc FTL.jj"

	local f
	for f in FMParser FMParserTokenManager; do
		sed -i -e "s|TOKEN_TEMPLATE|template|g" \
			src/main/java/freemarker/core/${f}.java \
			|| die "Failed to correct left over tokens"
	done

# Remove for now due to removal from jaxen, need to use pure jdom
	rm -r src/main/java/freemarker/ext/jdom/ \
		src/main/java/freemarker/ext/xml/_JdomNavigator.java \
		|| die "Failed to remove jdom support"
# Switched to patch remove after first commit
	# upgrade jdom -> jdom2
#	for f in jdom/NodeListModel xml/_JdomNavigator; do
#		sed -i -e "s|org.jdom|org.jdom2|g" \
#			-e "s|n) node).getParent|n) node).getParentElement|g" \
#			-e "s|t) node).getParent|t) node).getParentElement|g" \
#			-e "s|parent.getParent|parent.getParentElement|g" \
#			-e "s|getValue(localName)|getValue()|" \
#			-e "s|extends XMLOutputter||" \
#			src/main/java/freemarker/ext/${f}.java \
#			|| die "Failed to sed upgrade jdom -> jdom2 ${f}.java"
#	done

	# fix jython
	sed -i -e "s|PyJavaInstance|PyInstance|g" \
		src/main/java/freemarker/ext/jython/_Jython{20And21,22}VersionAdapter.java \
		|| die "Failed to sed PyJavaInstance -> PyInstance"
	sed -i -e "s|getFullName|getName|" \
		src/main/java/freemarker/ext/jython/_Jython22VersionAdapter.java \
		|| die "Failed to sed jython getFullName -> getName"
	sed -i -e "s|__class__.__name__|getType().getName()|" \
		src/main/java/freemarker/ext/jython/_Jython20And21VersionAdapter.java \
		|| die "Failed to sed jython getFullName -> getName"

	# fix serlvet-api/jsp
	cp src/main/java/freemarker/ext/jsp/_FreeMarkerPageContext21.java \
		src/main/java/freemarker/ext/jsp/_FreeMarkerPageContext2.java \
		|| die "Failed to copy _FreeMarkerPageContext21 -> 2"
	sed -i -e "s|21|2|g" \
		src/main/java/freemarker/ext/jsp/_FreeMarkerPageContext2.java \
		|| die "Failed to sed FreeMarkerJspFactory2"
	cp src/main/java/freemarker/ext/jsp/FreeMarkerJspFactory21.java \
		src/main/java/freemarker/ext/jsp/FreeMarkerJspFactory2.java \
		|| die "Failed to copy FreeMarkerJspFactory21 -> 2"
	sed -i -e "s|21|2|g" \
		src/main/java/freemarker/ext/jsp/FreeMarkerJspFactory2.java \
		|| die "Failed to sed FreeMarkerJspFactory2"
}
