# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BND_SLOT="4"

CP_DEPEND="dev-java/aqute-services-struct:0
	dev-java/bnd-annotation:${BND_SLOT}
	dev-java/bndlib:${BND_SLOT}
	dev-java/libg:${BND_SLOT}
	java-virtuals/servlet-api:4.0"

MY_PN=${PN/aqute/aQute}
MY_PN=${MY_PN//-/.}

inherit java-pkg

DESCRIPTION="aQute Remote provides remote debugging for bnd projects"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
SRC_URI="https://github.com/pkriens/aQute.repo/blob/master/repo/${MY_PN}/${MY_PN}-${PV}.jar?raw=true -> ${P}.jar"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" app-arch/unzip:0"

S="${WORKDIR}/"

JAVA_SRC_DIR="OSGI-OPT/src/"
