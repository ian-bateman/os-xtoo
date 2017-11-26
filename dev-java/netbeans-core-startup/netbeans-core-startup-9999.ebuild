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

java_prepare() {
	local p r s
	r="resources/META-INF/"
	mkdir -p ${r}services ${r}namedservices/URLStreamHandler/nbres{,loc} \
		|| die "Failed to make services directories"

	# services
	r="${r}services/"
	p="org.netbeans.core.startup"
	echo "${p}.CLITestModuleReload
${p}.CLICoreBridge
${p}.CLIOptions
" > "${r}org.netbeans.CLIHandler" \
		|| die "Failed to generate org.netbeans.CLIHandler"

	echo "${p}.impl.BinaryLayerFactoryProvider" > \
		"${r}${p}.base.LayerFactory\$Provider" \
		|| die "Failed to generate ${p}.base.LayerFactory\$Provider"

	echo "${p}.NbRepository" > "${r}org.openide.filesystems.Repository" \
		|| die "Failed to generate org.openide.filesystems.Repository"

	echo "${p}.ModuleLifecycleManager" > "${r}org.openide.LifecycleManager" \
		|| die "Failed to generate org.openide.LifecycleManager"

	echo "${p}.InstalledFileLocatorImpl" > \
		"${r}org.openide.modules.InstalledFileLocator" \
		|| die "Failed to generate org.openide.modules.InstalledFileLocator"

	echo "${p}.NbPlaces" > "${r}org.openide.modules.Places" \
		|| die "Failed to generate org.openide.modules.Places"

	echo "${p}.MainLookup" > "${r}org.openide.util.Lookup" \
		|| die "Failed to generate org.openide.util.Lookup"

	echo "${p}.preferences.PreferencesProviderImp" > \
		"${r}org.openide.util.NbPreferences\$Provider" \
		|| die "Failed to generate org.openide.util.NbPreferences\$Provider"

	# namedservices
	r="${r/services\//}namedservices/URLStreamHandler/"
	for s in nbres nbresloc; do
		echo "${p}.NbResourceStreamHandler" > \
			"${r}${s}/java.net.URLStreamHandler" \
			|| die "Failed to generate ${s}/java.net.URLStreamHandler"
	done
}
