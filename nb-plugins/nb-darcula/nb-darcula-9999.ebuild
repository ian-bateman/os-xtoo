# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/Revivius/${PN}"

inherit java-netbeans

if [[ ${PV} != 9999 ]]; then
	MY_SNAP="d00114bf060ae9ed3f438edb5b19ce7017cc94fe"
	SRC_URI="${BASE_URI}/archive/${MY_SNAP}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_SNAP}"
fi

DESCRIPTION="Darcula LAF for NetBeans"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

NB_SLOT="9"

CP_DEPEND="
	dev-java/darcula:0
	dev-java/iconloader:0
	nb-ide/netbeans-o-n-swing-plaf:${NB_SLOT}
	nb-ide/netbeans-openide-awt:${NB_SLOT}
	nb-ide/netbeans-openide-dialogs:${NB_SLOT}
	nb-ide/netbeans-openide-filesystems:${NB_SLOT}
	nb-ide/netbeans-openide-modules:${NB_SLOT}
	nb-ide/netbeans-openide-nodes:${NB_SLOT}
	nb-ide/netbeans-openide-util:${NB_SLOT}
	nb-ide/netbeans-openide-util-lookup:${NB_SLOT}
	nb-ide/netbeans-openide-util-ui:${NB_SLOT}
	nb-ide/netbeans-openide-windows:${NB_SLOT}
	nb-ide/netbeans-options-api:${NB_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports=java.desktop/sun.swing=ALL-UNNAMED "
