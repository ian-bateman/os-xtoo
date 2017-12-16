# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9:*"

ASM_SLOT="6"
LUCENE_SLOT="3"
OSGI_SLOT="6"
XERCES_SLOT="2"

RDEPEND="
	dev-java/asm:${ASM_SLOT}
	dev-java/freemarker:0
	dev-java/jsr305:0
	dev-java/lucene-core:${LUCENE_SLOT}
	~dev-java/${PN}-autoupdate-cli-${PV}:${SLOT}
	~dev-java/${PN}-autoupdate-pluginimporter-${PV}:${SLOT}
	~dev-java/${PN}-css-model-${PV}:${SLOT}
	~dev-java/${PN}-core-browser-${PV}:${SLOT}
	~dev-java/${PN}-core-execution-${PV}:${SLOT}
	~dev-java/${PN}-core-ide-${PV}:${SLOT}
	~dev-java/${PN}-core-io-ui-${PV}:${SLOT}
	~dev-java/${PN}-core-kit-${PV}:${SLOT}
	~dev-java/${PN}-core-multitabs-${PV}:${SLOT}
	~dev-java/${PN}-core-multitabs-project-${PV}:${SLOT}
	~dev-java/${PN}-core-multiview-${PV}:${SLOT}
	~dev-java/${PN}-core-netigso-${PV}:${SLOT}
	~dev-java/${PN}-core-network-${PV}:${SLOT}
	~dev-java/${PN}-core-osgi-${PV}:${SLOT}
	~dev-java/${PN}-core-output2-${PV}:${SLOT}
	~dev-java/${PN}-core-ui-${PV}:${SLOT}
	~dev-java/${PN}-editor-actions-${PV}:${SLOT}
	~dev-java/${PN}-editor-bookmarks-${PV}:${SLOT}
	~dev-java/${PN}-editor-bracesmatching-${PV}:${SLOT}
	~dev-java/${PN}-editor-global-format-${PV}:${SLOT}
	~dev-java/${PN}-editor-fold-nbui-${PV}:${SLOT}
	~dev-java/${PN}-editor-indent-project-${PV}:${SLOT}
	~dev-java/${PN}-editor-indent-support-${PV}:${SLOT}
	~dev-java/${PN}-editor-plain-${PV}:${SLOT}
	~dev-java/${PN}-editor-macros-${PV}:${SLOT}
	~dev-java/${PN}-editor-mimelookup-impl-${PV}:${SLOT}
	~dev-java/${PN}-editor-search-${PV}:${SLOT}
	~dev-java/${PN}-editor-settings-storage-${PV}:${SLOT}
	~dev-java/${PN}-extbrowser-${PV}:${SLOT}
	~dev-java/${PN}-git-${PV}:${SLOT}
	~dev-java/${PN}-ide-${PV}:${SLOT}
	~dev-java/${PN}-java-platform-ui-${PV}:${SLOT}
	~dev-java/${PN}-java-project-${PV}:${SLOT}
	~dev-java/${PN}-javahelp-${PV}:${SLOT}
	~dev-java/${PN}-keyring-${PV}:${SLOT}
	~dev-java/${PN}-libs-asm-${PV}:${SLOT}
	~dev-java/${PN}-libs-freemarker-${PV}:${SLOT}
	~dev-java/${PN}-localhistory-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-linux-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-nio2-${PV}:${SLOT}
	~dev-java/${PN}-masterfs-ui-${PV}:${SLOT}
	~dev-java/${PN}-o-n-swing-dirchooser-${PV}:${SLOT}
	~dev-java/${PN}-o-n-upgrader-${PV}:${SLOT}
	~dev-java/${PN}-openide-execution-${PV}:${SLOT}
	~dev-java/${PN}-openide-compat-${PV}:${SLOT}
	~dev-java/${PN}-openide-options-${PV}:${SLOT}
	~dev-java/${PN}-options-keymap-${PV}:${SLOT}
	~dev-java/${PN}-parsing-nb-${PV}:${SLOT}
	~dev-java/${PN}-parsing-ui-${PV}:${SLOT}
	~dev-java/${PN}-progress-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-ant-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-libraries-ui-${PV}:${SLOT}
	~dev-java/${PN}-project-spi-intern-impl-${PV}:${SLOT}
	~dev-java/${PN}-projectapi-nb-${PV}:${SLOT}
	~dev-java/${PN}-projectui-${PV}:${SLOT}
	~dev-java/${PN}-properties-syntax-${PV}:${SLOT}
	~dev-java/${PN}-spi-actions-${PV}:${SLOT}
	~dev-java/${PN}-spi-navigator-${PV}:${SLOT}
	~dev-java/${PN}-spi-palette-${PV}:${SLOT}
	~dev-java/${PN}-templatesui-${PV}:${SLOT}
	~dev-java/${PN}-uihandler-${PV}:${SLOT}
	~dev-java/${PN}-updatecenters-${PV}:${SLOT}
	~dev-java/${PN}-utilities-project-${PV}:${SLOT}
	~dev-java/${PN}-versioning-indexingbridge-${PV}:${SLOT}
	~dev-java/${PN}-versioning-masterfs-${PV}:${SLOT}
	~dev-java/${PN}-versioning-system-cvss-installer-${PV}:${SLOT}
	~dev-java/${PN}-versioning-ui-${PV}:${SLOT}
	~dev-java/${PN}-xml-catalog-ui-${PV}:${SLOT}
	~dev-java/${PN}-xml-multiview-${PV}:${SLOT}
	~dev-java/${PN}-xml-tax-${PV}:${SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	>=virtual/jdk-9:*
"
#	~dev-java/${PN}-openide-filesystem-compat8-${PV}:${SLOT}

S="${S%*${PN}}"

#o.n.bootstrap/launcher/unix/nbexec
NB_LAUNCHER="ide/launcher/unix/${PN}"

src_prepare() {
	default
	sed -i -e 's|"${userdir}"/etc|/etc/'${PN}'-'${SLOT}'|' -e 's|$X/||g' \
		-e '/-clusters/d' -e '/netbeans\.accept_license/d' \
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

symlink_libs() {
	local j
	for j in "${@}"; do
		dosym "../../${j}/lib/${j}.jar" \
			"/usr/share/${PN}-${SLOT}/lib/${j}.jar"
	done
}

src_install() {
	local icon icon_dir j jdir jars jars_short my_pn
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

	# symlink keystore
	dosym ../../${PN}-updatecenters-${SLOT}/ks/ide.ks \
		/usr/share/${my_pn}/core/ide.ks

	# symlink jars in core
	jdir=lib # use lib vs core for now
	jars=( core-startup core-startup-base libs-asm o-n-core )
	symlink_jars "/usr/share/${my_pn}/${jdir}" ${jars[@]}
	dosym ../../asm-${ASM_SLOT}/lib/asm.jar \
		/usr/share/${my_pn}/${jdir}/asm.jar
	dosym ../../jsr305/lib/jsr305.jar \
		/usr/share/${my_pn}/${jdir}/jsr305.jar

	# symlink jars in lib
	jars=(
		o-n-bootstrap o-n-upgrader openide-filesystems openide-modules
		openide-util openide-util-lookup openide-util-ui
	)
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]}

	jars_short=( core jsch sshagent usocket-jna )
	jars=( ${jars_short[@]/#/jsch-agent-proxy-} )

	jars_short=( "" "-boot" "-boot-fx" "-json" )
	jars+=( ${jars_short[@]/#/net-java-html} )

	jars+=(
		eclipse-jgit freemarker javaewah jsch xml-commons-resolver
		slf4j-api
	)
	symlink_libs ${jars[@]}

	dosym ../../lucene-core-${LUCENE_SLOT}/lib/lucene-core.jar \
		/usr/share/${my_pn}/lib/lucene-core.jar

	dosym ../../osgi-core-api-${OSGI_SLOT}/lib/osgi-core-api.jar \
		/usr/share/${my_pn}/lib/osgi-core-api.jar
#	java-netbeans_create-module-xml "osgi-core-api" lib 0

	dosym ../../xerces-${XERCES_SLOT}/lib/xerces.jar \
		/usr/share/${my_pn}/lib/xerces.jar

	for j in "${jars[@]}"; do
		dosym ../../${j}/lib/${j}.jar \
			/usr/share/${my_pn}/lib/${j}.jar
	done

	# symlink jars in modules
	jars_short=(
		annotations-common intent io progress progress-nb java
		java-classpath templates xml xml-ui
	)
	jars=( ${jars_short[@]/#/api-} )

	jars_short=( cli pluginimporter services ui )
	jars+=( ${jars_short[@]/#/autoupdate-} )

	jars_short=(
		browser execution ide io-ui kit multitabs multitabs-project
		multiview netigso network osgi output2 windows ui
	)
	jars+=( ${jars_short[@]/#/core-} )

	jars_short=( api types )
	jars+=( ${jars_short[@]/#/csl-} )

	jars_short=( lib model )
	jars+=( ${jars_short[@]/#/css-} )

	jars_short=(
		actions bookmarks bracesmatching breadcrumbs codetemplates
		completion deprecated-pre65formatting document errorstripe
		errorstripe-api fold fold-nbui global-format guards indent
		indent-support lib lib2 macros mimelookup mimelookup-impl
		plain plain-lib search settings settings-lib settings-storage
		structure util
	)
	jars+=( ${jars_short[@]/#/editor-} )

	jars_short=( browser execution execution-base )
	jars+=( ${jars_short[@]/#/ext} )

	jars_short=( platform platform-ui project )
	jars+=( ${jars_short[@]/#/java-} )

	jars_short=( freemarker jsch-agentproxy git )
	jars+=( ${jars_short[@]/#/libs-} )

	jars_short=(
		actions awt compat dialogs execution explorer filesystems-nb
		io loaders nodes options text windows
	)
	jars+=( ${jars_short[@]/#/openide-} )

	jars_short=( dirchooser outline plaf tabcontrol )
	jars+=( ${jars_short[@]/#/o-n-swing-} )

	jars_short=( "" "-linux" -"nio2" "-ui" )
	jars+=( ${jars_short[@]/#/masterfs} )

	jars_short=( api editor keymap )
	jars+=( ${jars_short[@]/#/options-} )

	jars_short=( api indexing lucene nb ui )
	jars+=( ${jars_short[@]/#/parsing-} )

	jars_short=(
		"-ant" "-ant-ui" api api-nb "-indexingbridge" "-libraries"
		"-libraries-ui" "-spi-intern" "-spi-intern-impl" uiapi
		uiapi-base
	)
	jars+=( ${jars_short[@]/#/project} )

	jars_short=( api )
	jars+=( ${jars_short[@]/#/refactoring-} )

	jars_short=( "" "-apimodule" )
	jars+=( ${jars_short[@]/#/spellchecker} )

	jars_short=(
		actions editor-hints navigator palette quicksearch tasklist
	)
	jars+=( ${jars_short[@]/#/spi-} )

	jars_short=( "" ui )
	jars+=( ${jars_short[@]/#/templates} )

	jars_short=( "" "-project" )
	jars+=( ${jars_short[@]/#/utilities} )

	jars_short=(
		"" "-core" "-masterfs" "-system-cvss-installer" "-util" "-ui"
	)
	jars+=( ${jars_short[@]/#/versioning} )

	jars_short=(
		"" "-axi" "-catalog" "-catalog-ui" "-core" "-lexer" "-multiview"
		"-retriever" "-schema-model" "-tax" "-text" "-xam"
	)
	jars+=( ${jars_short[@]/#/xml} )

	jars+=(
		classfile diff editor favorites git ide javahelp jumpto
		keyring lexer lib-uihandler localhistory progress-ui properties
		properties-syntax queries sampler sendopts settings
		team-commons uihandler updatecenters web-common
	)
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]} # use lib vs modules for now

#	local j
#	for j in "${jars[@]}"; do
#		java-netbeans_create-module-xml "${j}" lib
#	done

	# install icon
	icon="${my_pn}.png"
	icon_dir=/usr/share/icons/hicolor/128x128/apps
	dodir ${icon_dir}
	insinto ${icon_dir}
	newins ide.branding/release/${PN}.png ${icon}
	dosym ../../..${icon_dir}/${icon} /usr/share/pixmaps/${icon}

	make_desktop_entry ${my_pn} "Netbeans ${SLOT}" ${my_pn} Development
}
