# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

JAVA_NO_SRC=1

DEPEND=">=virtual/jdk-9"

#	~nb-ide/netbeans-core-?-${PV}:${SLOT}
#	~nb-ide/netbeans-libs-felix-${PV}:${SLOT}
#	~nb-ide/netbeans-print-${PV}:${SLOT}
RDEPEND="
	~nb-ide/netbeans-autoupdate-cli-${PV}:${SLOT}
	~nb-ide/netbeans-autoupdate-services-${PV}:${SLOT}
	~nb-ide/netbeans-autoupdate-ui-${PV}:${SLOT}
	~nb-ide/netbeans-core-ui-${PV}:${SLOT}
	~nb-ide/netbeans-core-windows-${PV}:${SLOT}
	~nb-ide/netbeans-favorites-${PV}:${SLOT}
	~nb-ide/netbeans-masterfs-${PV}:${SLOT}
	~nb-ide/netbeans-options-api-${PV}:${SLOT}
	~nb-ide/netbeans-options-keymap-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-swing-plaf-${PV}:${SLOT}
	>=virtual/jre-9
"
