# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JGroups"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/belaban/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/log4j:0
	dev-java/log4j-api:0
	dev-java/log4j-core:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="JGroups is a toolkit for reliable multicast communication"
HOMEPAGE="https://www.jgroups.org/"
LICENSE="LGPL-2.1"
SLOT="${PV%%.*}"

DEPEND+=" dev-java/bnd:4"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src"

java_prepare() {
	sed -i -e "/Bundle-Required*/d" "${S}/conf/jgroups.bnd" \
		|| die "Could not remove BREE from jgroups.bnd"
}

src_install() {
#	java-osgi_dojar "${PN}.jar" "org.jgroups" "${MY_PN}" \
#		"Export-Package: org.jgroups"
#	mv "${PN}.jar" "bnd-${PN}.jar"
#	bnd wrap -o "${PN}.jar" "bnd-${PN}.jar" \
#		|| die "Could not wrap jar via bnd"
	java-pkg-simple_src_install
}
