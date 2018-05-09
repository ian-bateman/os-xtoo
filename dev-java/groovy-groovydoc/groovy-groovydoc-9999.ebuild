# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PNL="${PN:0:6}"
MY_PN="${MY_PNL^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://github.com/apache/${MY_PNL}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PNL}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Groovy ${PN:8}"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/antlr:0
	~dev-java/groovy-${PV}:0
	~dev-java/groovy-templates-${PV}:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/subprojects/${PN}"

src_compile() {
	java-pkg-simple_src_compile

	# Temp needs to be moved to groovy eclass
	local sources classes
	sources=groovy_sources.lst
	classes=target/groovy_classes
	find "${S}/src/main/groovy" -name \*.groovy > ${sources}
	groovyc -d ${classes} -cp ${PN}.jar @${sources} \
		|| die "Failed to compile groovy files"
	# ugly should be included with existing
	jar uf ${PN}.jar -C ${classes} . || die "update jar failed"
}
