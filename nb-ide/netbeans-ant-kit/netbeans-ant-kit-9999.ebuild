# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"
RDEPEND="
	~nb-ide/netbeans-ant-browsetask-${PV}:${SLOT}
	~nb-ide/netbeans-ant-debugger-${PV}:${SLOT}
	~nb-ide/netbeans-ant-freeform-${PV}:${SLOT}
	~nb-ide/netbeans-ide-kit-${PV}:${SLOT}
	~nb-ide/netbeans-o-apache-tools-ant-module-${PV}:${SLOT}
	>=virtual/jre-9
"

JAVA_NO_SRC=0
