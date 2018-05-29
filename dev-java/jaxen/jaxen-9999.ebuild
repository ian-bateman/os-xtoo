# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="V_${PV//./_}_Final"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/codehaus/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/dom4j:2"

inherit java-pkg

DESCRIPTION="Universal Java XPath engine"
HOMEPAGE="${BASE_URI}"
LICENSE="JDOM"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="src/java/main/"
JAVA_RM_FILES=(
	src/java/main/org/jaxen/{jdom,xom}
	src/java/main/org/w3c/dom/UserDataHandler.java
)
