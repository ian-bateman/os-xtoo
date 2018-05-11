# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
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
	# java 9 fix
	sed -i -e '186i\ \ \ \@Override\n\ \ \ \ public boolean isModifiableModule(java.lang.Module m) { return false; }' \
		-e '186i\ \ \ \ @Override\n \ \ \ \public void redefineModule(java.lang.Module module, java.util.Set<java.lang.Module>extraReads, java.util.Map<String, java.util.Set<java.lang.Module>>extraExports, java.util.Map<String, java.util.Set<java.lang.Module>>extraOpens, java.util.Set<Class<?>> extraUses,java.util.Map<Class<?>,List<Class<?>>> extraProvides) { int i; }' \
                src/org/netbeans/NbInstrumentation.java \
                || die "Failed to add java 9 missing abstract methods"
}
