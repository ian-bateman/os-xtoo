# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

# Needed if sed removed @StaticResource think needs StaticResourceProcessor
#	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
CP_DEPEND="
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS="--add-modules java.activation"

java_prepare() {
	sed -i -e "/StaticResource/d" \
		src/org/openide/awt/QuickSearch.java \
		|| "Failed to delete @StaticResource"
}
