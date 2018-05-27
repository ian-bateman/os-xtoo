# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.apache.${PN/-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/felix/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="felix-${MY_P}"
fi

OSGI_SLOT="5"

CP_DEPEND="
	dev-java/kxml:0
	dev-java/xpp:3
	dev-java/felix-gogo-runtime:0
	dev-java/felix-shell:0
	dev-java/felix-utils:0
	dev-java/osgi-annotation:0
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-service-obr:0
"

inherit java-pkg

DESCRIPTION="Felix Bundle Repostory"
HOMEPAGE="https://felix.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
