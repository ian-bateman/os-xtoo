# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="log4j"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/logging-log4j2"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}/${PN}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="logging-log4j2-${MY_P}/${PN}/"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Apache Logging Log4J2 Api"

HOMEPAGE="https://logging.apache.org/log4j/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/osgi-core-api:6"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${MY_S}/"

if [[ ${PV} == 2.8.2 ]]; then
	PATCHES=( "${FILESDIR}/ambiguous.patch" )
fi
