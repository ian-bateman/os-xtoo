# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/asm:6
	dev-java/javax-annotation:0
	~nb-ide/netbeans-core-startup-base-${PV}:${SLOT}
	~nb-ide/netbeans-o-n-bootstrap-${PV}:${SLOT}
	~nb-ide/netbeans-openide-filesystems-${PV}:${SLOT}
	~nb-ide/netbeans-openide-modules-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-ui-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	local r p s
	p="org.netbeans.core.startup"
	s="resources/META-INF/services/"
	r="resources/META-INF/namedservices/URLStreamHandler/"
	mkdir -p "${s}" "${r}"nbres{,loc} \
		|| die "Failed to make services namedservices directories"

	echo "org.openide.util.URLStreamHandlerRegistration" > \
		resources/META-INF/namedservices.index \
		|| die "Failed to generate META-INF/namedservices.index"

	echo "org.netbeans.modules.openide.util.ProxyURLStreamHandlerFactory" > \
		${s}java.net.URLStreamHandlerFactory \
		|| die "Failed to generate java.net.URLStreamHandlerFactory"

	echo "org.netbeans.modules.openide.util.NbBundleProcessor" > \
		${s}javax.annotation.processing.Processor \
		|| die "Failed to generate javax.annotation.processing.Processor"

	echo "org.netbeans.modules.openide.util.Compact2MutexEventProvider" > \
		${s}org.openide.util.spi.MutexEventProvider \
		|| die "Failed to generate org.openide.util.spi.MutexEventProvider"

	# java 9 fix
	sed -i -e '375,377d' src/org/netbeans/core/startup/Splash.java \
		|| die "Failed to remove code that causes exceptions"
}
