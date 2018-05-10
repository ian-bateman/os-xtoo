# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="org.${PN//-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/felix/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="felix-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Felix OSGi OBR service API"
HOMEPAGE="https://felix.apache.org"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/osgi-core-api:6"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"
