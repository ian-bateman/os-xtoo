# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	local r s
	r="resources/META-INF/namedservices/URLStreamHandler/nbinst"
	mkdir -p "${r}" \
		|| die "Failed to make services namedservices directories"

	echo "org.netbeans.core.startup.layers.NbinstURLStreamHandler" > \
		"${r}/java.net.URLStreamHandler" \
		|| die "Failed to generate URLStreamHandler"
}
