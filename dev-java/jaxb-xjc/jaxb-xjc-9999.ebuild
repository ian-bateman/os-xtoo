# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="jaxb-v2"
MY_PV="${PV%*.*.*}-b${PV#*.*.*.}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="JAXB Binding Compiler"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/codemodel:0
	dev-java/dtd-parser:0
	~dev-java/jaxb-core-${PV}:${SLOT}
	dev-java/istack-commons-runtime:0
	dev-java/istack-commons-tools:0
	dev-java/relaxng-datatype:0
	dev-java/rngom:0
	dev-java/txw2:0
	dev-java/xml-commons-resolver:0
	dev-java/xsom:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/jaxb-ri/xjc"

JAVAC_ARGS="--add-modules java.xml.bind"

java_prepare() {
	local f files
	# use external vs internal
	for f in CatalogUtil generator/bean/BeanGenerator; do
		sed -i -e "s|com.sun.org.apache.xml.internal|org.apache.xml|g" \
			src/main/java/com/sun/tools/xjc/${f}.java \
			|| die "Failed to make commons-xml-resolver external"
	done
}
