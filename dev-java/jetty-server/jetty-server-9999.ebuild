# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jetty"
MY_PV="${PV/.201/.v201}"
MY_PV="${MY_PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}.project"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}.project-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	~dev-java/jetty-http-${PV}:${SLOT}
	~dev-java/jetty-io-${PV}:${SLOT}
	~dev-java/jetty-jmx-${PV}:${SLOT}
	~dev-java/jetty-util-${PV}:${SLOT}
	java-virtuals/servlet-api:3.1
"
# Fails to build with 4.0 :(

inherit java-pkg

DESCRIPTION="Jetty's server API (not the server itself)"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/documentation/current/alpn-chapter.html"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
