# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN%-*}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/commons-collections:0
	dev-java/commons-dbcp:2
	dev-java/commons-pool:2
	dev-java/log4j:0
	~dev-java/olap4j-${PV}:${SLOT}
	dev-java/xerces:2
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="XML for Analysis (XMLA) server based upon an olap4j connection"
HOMEPAGE="https://www.${PN}.org/"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# upgrade to dbcp2
	sed -i -e "s|.dbcp.|.dbcp2.|g" \
		-e "s|setMaxActive|setMaxTotal|"\
		src/main/java/mondrian/xmla/impl/Olap4jXmlaServlet.java \
		|| die "Failed to sed dbcp -> dbcp2"
}
