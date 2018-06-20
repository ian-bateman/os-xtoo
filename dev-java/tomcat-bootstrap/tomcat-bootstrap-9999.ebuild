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
	~dev-java/tomcat-catalina-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	~dev-java/tomcat-util-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Tomcat's ${PN#-*}"
HOMEPAGE="https://tomcat.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	java/org/apache/catalina/webresources/war
	java/org/apache/catalina/security
	java/org/apache/catalina/startup
	java/org/apache/tomcat/util/buf
"
JAVA_RES_DIR="java/resources"

java_prepare() {
	local p

	p="java/org/apache"
	find ${p}/catalina/webresources/war/ -type f \
		-not -name 'Handler*' -not -name 'WarURLConnection*' -delete \
		|| die "Failed to remove sources from webresources"

	find ${p}/catalina/security/ -type f \
		-not -name 'SecurityClassLoad*' -delete \
		|| die "Failed to remove sources from security"

	find ${p}/catalina/startup/ -type f \
		-not -name 'Bootstrap*' -not -name 'CatalinaProperties*' \
		-not -name 'ClassLoader*' -not -name 'SafeForkJoin*' \
		-not -name 'Tool*' -delete \
		|| die "Failed to remove sources from security"

	find ${p}/tomcat/util/buf/ -type f -not -name 'UriUtil*' -delete \
		|| die "Failed to remove sources from util/buf"

	mkdir -p ${JAVA_RES_DIR}/org/apache/catalina/startup \
		|| die "Failed to make resources directory"

	cp conf/catalina.properties \
		${JAVA_RES_DIR}/org/apache/catalina/startup \
		|| die "Failed to copy catalina.properties"
}
