# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/kohsuke/msv"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="msv-${P}"
fi

CP_DEPEND="
	dev-java/relaxng-datatype-java:0
	dev-java/xerces:2
"

inherit java-pkg

DESCRIPTION="XML Schema datatypes library"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"
