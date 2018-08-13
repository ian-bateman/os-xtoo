# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-cli:1
	dev-java/commons-collections:0
	dev-java/commons-discovery:0
	dev-java/commons-jexl:2
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/dom4j:2
	dev-java/jaxen:0
	dev-java/taglibs-standard-spec:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Jelly is a tool for turning XML into executable code"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=( src/java/org/apache/commons/jelly/test )
JAVA_SRC_DIR="src/java"
