# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_P="de.kalpatec.${PN/-/.}-${PV}"
BASE_URI="https://github.com/lefou/pojosr"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/lefou/pojosr/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/osgi-compendium:4
	dev-java/osgi-core-api:4
"

inherit java-pkg

DESCRIPTION="Service registry that enables OSGi style service registry programs"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/pojosr-${MY_P}"
