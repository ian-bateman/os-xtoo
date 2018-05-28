# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/ebourg/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="dev-java/tomcat-servlet-api:4.0"

inherit java-pkg

DESCRIPTION="binary web service protocol"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-1.0"
SLOT="0"

S="${WORKDIR}/${P}"
