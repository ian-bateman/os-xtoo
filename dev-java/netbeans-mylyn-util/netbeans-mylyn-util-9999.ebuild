# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

ECLIPSE_SLOT="4.7"
MYLYN_SLOT="3"

CP_DEPEND="
	dev-java/eclipse-core-jobs:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/eclipse-mylyn-commons-net:${MYLYN_SLOT}
	dev-java/eclipse-mylyn-tasks-core:${MYLYN_SLOT}
	dev-java/eclipse-mylyn-wikitext:3
	~dev-java/netbeans-bugtracking-${PV}:${SLOT}
	~dev-java/netbeans-keyring-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-spellchecker-${PV}:${SLOT}
	~dev-java/netbeans-spellchecker-apimodule-${PV}:${SLOT}
	~dev-java/netbeans-team-commons-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	sed -i -e "s|wikitext.core|wikitext|g" \
		src/org/netbeans/modules/mylyn/util/WikiUtils.java \
		|| die "Failed to sed/update mylyn wikitext imports"
}
