# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"

JUNIT_SLOT="4"
SWING_SLOT="1"

RDEPEND="
	dev-java/junit:4
	~dev-java/netbeans-api-java-${PV}:${SLOT}
	~dev-java/netbeans-core-ide-${PV}:${SLOT}
	~dev-java/netbeans-core-multitabs-${PV}:${SLOT}
	~dev-java/netbeans-masterfs-linux-${PV}:${SLOT}
	~dev-java/netbeans-o-n-upgrader-${PV}:${SLOT}
	~dev-java/netbeans-openide-execution-${PV}:${SLOT}
	~dev-java/netbeans-openide-compat-${PV}:${SLOT}
	~dev-java/netbeans-openide-options-${PV}:${SLOT}
	dev-java/swing-layout:1
	>=virtual/jdk-9
"

S="${S%*${PN}}"

#o.n.bootstrap/launcher/unix/nbexec
NB_LAUNCHER="ide/launcher/unix/netbeans"

src_prepare() {
	default
	sed -i -e 's|"${userdir}"/etc|/etc/'${PN}'-'${SLOT}'|' \
		-e 's|$X/||g' \
		-e 's|'''"$netbeans_jdkhome"'''|$(java-config -O)|g' \
		${NB_LAUNCHER} \
		|| die "Failed to sed/update launcher script"
}

src_compile() {
:
}

symlink_jars() {
	local j
	for j in "${@:2}"; do
		dosym "../../${PN}-${j}-${SLOT}/lib/${PN}-${j}.jar" \
			"${1}/${PN}-${j}.jar"
	done
}

src_install() {
	local icon icon_dir jars jars_short my_pn
	my_pn="netbeans-${SLOT}"

	dodir /etc/${my_pn}
	insinto /etc/${my_pn}
	doins ide/launcher/${PN}.conf
	doins ide/launcher/${PN}.clusters

	dodir /usr/share/${my_pn}/{bin,core,docs,lib,modules}
	dodir /usr/share/${my_pn}/config/Module{s,AutoDeps}

	insinto /usr/share/${my_pn}
	doins core.kit/release/VERSION.txt
#	newins	"?" moduleCluster.properties

	exeinto /usr/share/${my_pn}/bin
	doexe ${NB_LAUNCHER}

	exeinto /usr/share/${my_pn}/lib
	doexe o.n.bootstrap/launcher/unix/nbexec

	# symlink etc and launchers/bins
	dosym ../../../etc/${my_pn} /usr/share/${my_pn}/etc
	dosym ../share/${my_pn}/bin/${PN} /usr/bin/${my_pn}
	dosym ../share/${my_pn}/lib/nbexec /usr/bin/nbexec-${SLOT}

	# symlinks in docs
	dosym ../../junit-${JUNIT_SLOT}/sources/junit-src.zip \
		/usr/share/${my_pn}/docs/junit-sources.jar
	dosym ../../swing-layout-${SWING_SLOT}/sources/swing-layout-src.zip \
		/usr/share/${my_pn}/docs/swing-layout-sources.jar

	# symlink jars in core
	jars=( core-startup core-startup-base o-n-core openide-filesystems )
	symlink_jars "/usr/share/${my_pn}/core" ${jars[@]}

	# symlink jars in lib
	jars=( o-n-bootstrap o-n-upgrader openide-modules openide-util
		openide-util-lookup openide-util-ui
	)
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]}

	# symlink jars in modules
	jars_short=(
		intent io progress progress-nb java templates
	)
	jars+=( ${jars_short[@]/#/api-} )
	jars_short=(
		ide multitabs startup-base windows
	)
	jars+=( ${jars_short[@]/#/core-} )
	jars_short=(
		actions awt compat dialogs execution explorer filesystems
		io loaders nodes options text windows
	)
	jars+=( ${jars_short[@]/#/openide-} )
	jars_short=( outline plaf tabcontrol )
	jars+=( ${jars_short[@]/#/o-n-swing-} )
	jars+=( masterfs masterfs-linux )
	symlink_jars "/usr/share/${my_pn}/modules" ${jars[@]}

	# install icon
	icon="${my_pn}.png"
	icon_dir=/usr/share/icons/hicolor/128x128/apps
	dodir ${icon_dir}
	insinto ${icon_dir}
	newins ide.branding/release/${PN}.png ${icon}
	dosym ../../..${icon_dir}/${icon} /usr/share/pixmaps/${icon}

	make_desktop_entry ${my_pn} "Netbeans ${SLOT}" ${my_pn} Development
}
