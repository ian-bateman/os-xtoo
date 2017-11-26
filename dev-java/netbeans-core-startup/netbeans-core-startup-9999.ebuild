# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

NB_BUNDLE=0

CP_DEPEND="
	dev-java/asm:6
	~dev-java/netbeans-core-startup-base-${PV}:${SLOT}
	~dev-java/netbeans-o-n-bootstrap-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

NB_PROC=",org.netbeans.modules.openide.util.NamedServiceProcessor"
NB_PROC+=",org.netbeans.modules.openide.util.ServiceProviderProcessor"

java_prepare() {
	local p r s
	r="resources/META-INF/namedservices/URLStreamHandler/"
	mkdir -p ${r}nbres{,loc} \
		|| die "Failed to make namedservices directories"

	# namedservices
	for s in nbres{,loc}; do
		echo "${p}.NbResourceStreamHandler" > \
			"${r}${s}/java.net.URLStreamHandler" \
			|| die "Failed to generate ${s}/java.net.URLStreamHandler"
	done
}
