# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="${PN^}"
BASE_URI="https://github.com/bulenkov/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	MY_SNAP="49774425c392c36d926b8a4518a3616a8cf735e2"
	SRC_URI="${BASE_URI}/archive/${MY_SNAP}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_PN}-${MY_SNAP}"
fi

CP_DEPEND="
	dev-java/iconloader:0
	dev-java/intellij-platform-annotations:0
"

inherit java-pkg

DESCRIPTION="Darcula LAF"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports=java.desktop/sun.awt=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=java.desktop/sun.swing=ALL-UNNAMED "
