# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:14}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/commons-collections:0
	dev-java/commons-digester:2
	dev-java/commons-lang:2
	dev-java/commons-logging:0
	dev-java/commons-validator:0
	dev-java/dom4j:2
	dev-java/velocity-engine-core:0
	java-virtuals/servlet-api:2.5
"

inherit java-pkg

DESCRIPTION="Set of tools that ease Velocity integration ${PN:15}"
HOMEPAGE="https://velocity.apache.org/tools/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_RM_FILES=( src/main/java/org/apache/velocity/tools/struts )

java_prepare() {
	sed -i -e "s|kids.addAll((List<Node>)|kids.addAll(|" \
		src/main/java/org/apache/velocity/tools/generic/XmlTool.java \
		|| die "Failed to sed/fix for dom4j:2"
}
