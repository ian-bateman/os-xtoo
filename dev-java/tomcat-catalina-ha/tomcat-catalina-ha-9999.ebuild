# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-catalina-${PV}:${SLOT}
	~dev-java/tomcat-catalina-tribes-${PV}:${SLOT}
	~dev-java/tomcat-coyote-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:4.0
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-util-scan-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="java/org/apache/catalina/ha/"
JAVA_RES_FIND=" -not -name LocalStrings_*.properties "
JAVA_RES_RM_DIR=0
