# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/javahelp:0
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-windows-${PV}:${SLOT}
	~dev-java/netbeans-spi-quicksearch-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
