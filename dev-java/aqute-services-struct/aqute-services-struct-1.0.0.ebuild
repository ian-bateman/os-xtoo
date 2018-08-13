# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN=${PN/aqute/aQute}
MY_PN=${MY_PN//-/.}

DEPEND+=" app-arch/unzip:0"

inherit java-pkg

DESCRIPTION="aQute Services Struct"
HOMEPAGE="https://github.com/pkriens/aQute.repo/"
SRC_URI="https://github.com/pkriens/aQute.repo/blob/master/repo/${MY_PN}/${MY_PN}-${PV}.jar?raw=true -> ${P}.jar"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/"

JAVA_SRC_DIR="OSGI-OPT/src/"
