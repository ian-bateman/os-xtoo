# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"
RDEPEND="
	~nb-ide/netbeans-apisupport-ant-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-harness-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-installer-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-project-${PV}:${SLOT}
	~nb-ide/netbeans-apisupport-wizards-${PV}:${SLOT}
	~nb-ide/netbeans-java-kit-${PV}:${SLOT}
	>=virtual/jre-9
"

JAVA_NO_SRC=0
