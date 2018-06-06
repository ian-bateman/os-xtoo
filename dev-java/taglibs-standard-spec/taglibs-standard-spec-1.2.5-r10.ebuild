# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN%-*}-${PV}"

CP_DEPEND="dev-java/tomcat-servlet-api:4.0"

inherit java-pkg

DESCRIPTION="An implementation of the JSP Standard Tag Library (JSTL) ${PN##*-}"
HOMEPAGE="https://tomcat.apache.org/taglibs/standard/"
SRC_URI="mirror://apache/tomcat/${PN}/${MY_P}/${MY_P}-source-release.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_P}/${PN##*-}"
