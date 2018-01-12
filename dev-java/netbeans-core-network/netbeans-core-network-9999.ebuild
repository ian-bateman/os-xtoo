# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit java-netbeans

CP_DEPEND="
	dev-java/jna:4
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-o-n-core-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVA_RM_FILES=( src/org/netbeans/core/network/utils/hname/win )

java_prepare() {
	sed -i -e "59,60d" \
		src/org/netbeans/core/network/utils/HostnameUtils.java \
		|| die "Failed to remove windows support"
}
