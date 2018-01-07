# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	MY_PV="${PV/_beta/}"
	MY_P="apache-${MY_PN}-${MY_PV}-src"
	SRC_URI="mirror://apache/${MY_PN}/${MY_PN}-${PV%%.*}/v${MY_PV}/src/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:4.0
	~dev-java/tomcat-util-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR=( descriptor digester scan )
JAVA_SRC_DIR="${JAVA_SRC_DIR[@]/#/java/org/apache/tomcat/util/}"
JAVA_RES_DIR="resources"

java_prepare() {
	local d p

	p="org/apache/tomcat/util"
	mkdir -p resources/${p}/{descriptor/tld,descriptor/web,digester,scan} \
		|| die "Failed to make resources direcotries"

	for d in descriptor descriptor/tld descriptor/web digester scan ; do
		cp java/${p}/${d}/LocalStrings.properties resources/${p}/${d} \
			|| die "Failed to copy ${d}/LocalStrings.properties"
	done

	cp java/${p}/descriptor/web/mbeans-descriptors.xml \
		resources/${p}/descriptor/web \
		|| die "Failed to copy mbeans-descriptors.xml"
}
