# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9:*"

ANTLR3_SLOT="3"
ANTLR4_SLOT="4"
ASM_SLOT="6"
ECLIPSE_SLOT="4.7"
JUNIT_SLOT="4"
LUCENE_SLOT="3"
MYLYN_SLOT="3"
OSGI_SLOT="6"
WIKI_SLOT="3"
XERCES_SLOT="2"

RDEPEND="
	dev-java/ant-core:0
	dev-java/antlr:${ANTLR3_SLOT}
	dev-java/antlr:${ANTLR4_SLOT}
	dev-java/asm:${ASM_SLOT}
	dev-java/freemarker:0
	dev-java/javax-activation:0
	dev-java/javax-annotation:0
	dev-java/jaxb-api:0
	dev-java/jsr305:0
	dev-java/lucene-core:${LUCENE_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	~nb-ide/${PN}-ant-grammar-${PV}:${SLOT}
	~nb-ide/${PN}-ant-kit-${PV}:${SLOT}
	~nb-ide/${PN}-api-htmlui-${PV}:${SLOT}
	~nb-ide/${PN}-api-visual-${PV}:${SLOT}
	~nb-ide/${PN}-apisupport-ant-${PV}:${SLOT}
	~nb-ide/${PN}-apisupport-harness-${PV}:${SLOT}
	~nb-ide/${PN}-apisupport-project-${PV}:${SLOT}
	~nb-ide/${PN}-apisupport-refactoring-${PV}:${SLOT}
	~nb-ide/${PN}-apisupport-wizards-${PV}:${SLOT}
	~nb-ide/${PN}-autoupdate-cli-${PV}:${SLOT}
	~nb-ide/${PN}-autoupdate-pluginimporter-${PV}:${SLOT}
	~nb-ide/${PN}-bugtracking-bridge-${PV}:${SLOT}
	~nb-ide/${PN}-core-browser-${PV}:${SLOT}
	~nb-ide/${PN}-core-execution-${PV}:${SLOT}
	~nb-ide/${PN}-core-io-ui-${PV}:${SLOT}
	~nb-ide/${PN}-core-kit-${PV}:${SLOT}
	~nb-ide/${PN}-core-multitabs-project-${PV}:${SLOT}
	~nb-ide/${PN}-core-netigso-${PV}:${SLOT}
	~nb-ide/${PN}-core-network-${PV}:${SLOT}
	~nb-ide/${PN}-core-osgi-${PV}:${SLOT}
	~nb-ide/${PN}-core-output2-${PV}:${SLOT}
	~nb-ide/${PN}-core-ui-${PV}:${SLOT}
	~nb-ide/${PN}-css-prep-${PV}:${SLOT}
	~nb-ide/${PN}-css-visual-${PV}:${SLOT}
	~nb-ide/${PN}-dlight-nativeexecution-nb-${PV}:${SLOT}
	~nb-ide/${PN}-dlight-terminal-${PV}:${SLOT}
	~nb-ide/${PN}-editor-actions-${PV}:${SLOT}
	~nb-ide/${PN}-editor-bookmarks-${PV}:${SLOT}
	~nb-ide/${PN}-editor-global-format-${PV}:${SLOT}
	~nb-ide/${PN}-editor-fold-nbui-${PV}:${SLOT}
	~nb-ide/${PN}-editor-indent-project-${PV}:${SLOT}
	~nb-ide/${PN}-editor-indent-support-${PV}:${SLOT}
	~nb-ide/${PN}-editor-plain-${PV}:${SLOT}
	~nb-ide/${PN}-editor-macros-${PV}:${SLOT}
	~nb-ide/${PN}-editor-mimelookup-impl-${PV}:${SLOT}
	~nb-ide/${PN}-editor-search-${PV}:${SLOT}
	~nb-ide/${PN}-editor-settings-storage-${PV}:${SLOT}
	~nb-ide/${PN}-editor-tools-storage-${PV}:${SLOT}
	~nb-ide/${PN}-extbrowser-${PV}:${SLOT}
	~nb-ide/${PN}-extexecution-impl-${PV}:${SLOT}
	~nb-ide/${PN}-form-refactoring-${PV}:${SLOT}
	~nb-ide/${PN}-git-${PV}:${SLOT}
	~nb-ide/${PN}-gsf-codecoverage-${PV}:${SLOT}
	~nb-ide/${PN}-html-custom-${PV}:${SLOT}
	~nb-ide/${PN}-html-editor-${PV}:${SLOT}
	~nb-ide/${PN}-html-parser-${PV}:${SLOT}
	~nb-ide/${PN}-i18n-${PV}:${SLOT}
	~nb-ide/${PN}-ide-${PV}:${SLOT}
	~nb-ide/${PN}-ide-kit-${PV}:${SLOT}
	~nb-ide/${PN}-java-api-common-${PV}:${SLOT}
	~nb-ide/${PN}-java-debug-${PV}:${SLOT}
	~nb-ide/${PN}-java-editor-${PV}:${SLOT}
	~nb-ide/${PN}-java-freeform-${PV}:${SLOT}
	~nb-ide/${PN}-java-guards-${PV}:${SLOT}
	~nb-ide/${PN}-java-hints-${PV}:${SLOT}
	~nb-ide/${PN}-java-hints-declarative-${PV}:${SLOT}
	~nb-ide/${PN}-java-hints-legacy-spi-${PV}:${SLOT}
	~nb-ide/${PN}-java-j2sedeploy-${PV}:${SLOT}
	~nb-ide/${PN}-java-j2seplatform-${PV}:${SLOT}
	~nb-ide/${PN}-java-j2seprofiles-${PV}:${SLOT}
	~nb-ide/${PN}-java-kit-${PV}:${SLOT}
	~nb-ide/${PN}-java-metrics-${PV}:${SLOT}
	~nb-ide/${PN}-java-module-graph-${PV}:${SLOT}
	~nb-ide/${PN}-java-navigation-${PV}:${SLOT}
	~nb-ide/${PN}-java-platform-ui-${PV}:${SLOT}
	~nb-ide/${PN}-java-project-${PV}:${SLOT}
	~nb-ide/${PN}-java-source-ant-${PV}:${SLOT}
	~nb-ide/${PN}-java-source-compat8-${PV}:${SLOT}
	~nb-ide/${PN}-java-source-queriesimpl-${PV}:${SLOT}
	~nb-ide/${PN}-java-testrunner-${PV}:${SLOT}
	~nb-ide/${PN}-java-testrunner-ant-${PV}:${SLOT}
	~nb-ide/${PN}-javadoc-${PV}:${SLOT}
	~nb-ide/${PN}-javahelp-${PV}:${SLOT}
	~nb-ide/${PN}-junit-ui-${PV}:${SLOT}
	~nb-ide/${PN}-junitlib-${PV}:${SLOT}
	~nb-ide/${PN}-lexer-nbbridge-${PV}:${SLOT}
	~nb-ide/${PN}-libs-antlr3-runtime-${PV}:${SLOT}
	~nb-ide/${PN}-libs-antlr4-runtime-${PV}:${SLOT}
	~nb-ide/${PN}-libs-asm-${PV}:${SLOT}
	~nb-ide/${PN}-libs-freemarker-${PV}:${SLOT}
	~nb-ide/${PN}-localhistory-${PV}:${SLOT}
	~nb-ide/${PN}-localtasks-${PV}:${SLOT}
	~nb-ide/${PN}-masterfs-linux-${PV}:${SLOT}
	~nb-ide/${PN}-masterfs-nio2-${PV}:${SLOT}
	~nb-ide/${PN}-masterfs-ui-${PV}:${SLOT}
	~nb-ide/${PN}-o-n-swing-dirchooser-${PV}:${SLOT}
	~nb-ide/${PN}-o-n-upgrader-${PV}:${SLOT}
	~nb-ide/${PN}-openide-compat-${PV}:${SLOT}
	~nb-ide/${PN}-openide-filesystems-compat8-${PV}:${SLOT}
	~nb-ide/${PN}-openide-options-${PV}:${SLOT}
	~nb-ide/${PN}-options-keymap-${PV}:${SLOT}
	~nb-ide/${PN}-options-java-${PV}:${SLOT}
	~nb-ide/${PN}-parsing-nb-${PV}:${SLOT}
	~nb-ide/${PN}-parsing-ui-${PV}:${SLOT}
	~nb-ide/${PN}-progress-ui-${PV}:${SLOT}
	~nb-ide/${PN}-project-ant-ui-${PV}:${SLOT}
	~nb-ide/${PN}-project-libraries-ui-${PV}:${SLOT}
	~nb-ide/${PN}-project-spi-intern-impl-${PV}:${SLOT}
	~nb-ide/${PN}-projectapi-nb-${PV}:${SLOT}
	~nb-ide/${PN}-projectui-${PV}:${SLOT}
	~nb-ide/${PN}-projectui-buildmenu-${PV}:${SLOT}
	~nb-ide/${PN}-properties-syntax-${PV}:${SLOT}
	~nb-ide/${PN}-server-${PV}:${SLOT}
	~nb-ide/${PN}-spi-actions-${PV}:${SLOT}
	~nb-ide/${PN}-spi-editor-hints-projects-${PV}:${SLOT}
	~nb-ide/${PN}-spi-viewmodel-${PV}:${SLOT}
	~nb-ide/${PN}-team-ide-${PV}:${SLOT}
	~nb-ide/${PN}-templatesui-${PV}:${SLOT}
	~nb-ide/${PN}-uihandler-${PV}:${SLOT}
	~nb-ide/${PN}-updatecenters-${PV}:${SLOT}
	~nb-ide/${PN}-utilities-project-${PV}:${SLOT}
	~nb-ide/${PN}-versioning-indexingbridge-${PV}:${SLOT}
	~nb-ide/${PN}-versioning-masterfs-${PV}:${SLOT}
	~nb-ide/${PN}-versioning-system-cvss-installer-${PV}:${SLOT}
	~nb-ide/${PN}-xml-catalog-ui-${PV}:${SLOT}
	~nb-ide/${PN}-xml-multiview-${PV}:${SLOT}
	~nb-ide/${PN}-xml-schema-completion-${PV}:${SLOT}
	~nb-ide/${PN}-xml-text-obsolete90-${PV}:${SLOT}
	~nb-ide/${PN}-xml-tools-java-${PV}:${SLOT}
	~nb-ide/${PN}-xml-xdm-${PV}:${SLOT}
	~nb-ide/${PN}-xsl-${PV}:${SLOT}
	nb-plugins/flow-netbeans-markdown:0
	nb-plugins/nb-cmake-completion:0
	nb-plugins/nb-darcula:0
	>=virtual/jdk-9:*
"

S="${S%*${PN}}"

#o.n.bootstrap/launcher/unix/nbexec
NB_LAUNCHER="ide/launcher/unix/${PN}"

src_prepare() {
	default
	sed -i -e 's/,\?java.\(activation\|xml.bind\),\?//g' \
		ide/launcher/${PN}.conf \
		|| die "Failed to sed/fix ${PN}.conf for java 11, drop mods"

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
	local l p
	for p in "${@}"; do
		l="$(jem -p ${p})"
		[[ -z ${l} ]] && die "Jar not found for ${p}"
		dosym "${l/\/usr\/share\//../../}" \
			"/usr/share/${PN}-${SLOT}/lib/${l##*/}"
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
	jars=( filesystems filesystems-compat8 modules util util-lookup util-ui )
	jars=( ${jars[@]/#/openide-} o-n-bootstrap o-n-upgrader )
	symlink_jars "/usr/share/${my_pn}/lib" ${jars[@]}

	# symlink 3rd party
	jars_short=( contenttype jobs net runtime )
	jars=( ${jars_short[@]/#/core-} )

	jars_short=( app common preferences registry security )
	jars+=( ${jars_short[@]/#/equinox-} jdt-annotation osgi osgi-services )
	jars=( ${jars[@]/%/-${ECLIPSE_SLOT}} )

	jars_short=( core net repositories-core )
	jars_short=( ${jars_short[@]/#/mylyn-commons-} mylyn-tasks-core )
	jars+=( ${jars_short[@]/%/-${MYLYN_SLOT}} mylyn-wikitext-${WIKI_SLOT} )
	jars=( ${jars[@]/#/eclipse-} ) # eclipse jars needed by localtasks

	jars_short=( core jsch sshagent usocket-jna )
	jars+=( ${jars_short[@]/#/jsch-agent-proxy-} )

	jars_short=( "" "-boot" "-boot-fx" "-geo" "-json" )
	jars+=( ${jars_short[@]/#/net-java-html} )

	jars+=(
		byte-buddy-dep darcula eclipse-jgit flow-netbeans-markdown
		freemarker htmlparser iconloader intellij-platform-annotations
		javaewah javax-activation javax-annotation jaxb-api jsch
		json-simple junit-${JUNIT_SLOT} lucene-core-${LUCENE_SLOT}
		nb-cmake-completion nb-darcula osgi-core-api-${OSGI_SLOT}
		parboiled-core parboiled-java pegdown xerces-${XERCES_SLOT}
		xml-commons-resolver slf4j-api
	)
	symlink_libs ${jars[@]}

	dosym ../../ant-core/lib/ant.jar \
		/usr/share/${my_pn}/lib/ant.jar
	dosym ../../ant-core/lib/ant-bootstrap.jar \
		/usr/share/${my_pn}/lib/ant-bootstrap.jar
	dosym ../../ant-core/lib/ant-launcher.jar \
		/usr/share/${my_pn}/lib/ant-launcher.jar

	dosym ../../antlr-${ANTLR3_SLOT}/lib/antlr-runtime.jar \
		/usr/share/${my_pn}/lib/antlr3-runtime.jar

	dosym ../../antlr-${ANTLR4_SLOT}/lib/antlr-runtime.jar \
		/usr/share/${my_pn}/lib/antlr4-runtime.jar

#	java-netbeans_create-module-xml "osgi-core-api" lib 0

	# symlink jars in modules
	jars_short=( browsetask debugger freeform grammar kit )
	jars=( ${jars_short[@]/#/ant-} )

	jars_short=(
		annotations-common htmlui intent io progress progress-nb
		java java-classpath search templates visual xml xml-ui
	)
	jars+=( ${jars_short[@]/#/api-} )

	jars_short=( ant harness project refactoring wizards )
	jars+=( ${jars_short[@]/#/apisupport-} )

	jars_short=( cli pluginimporter services ui )
	jars+=( ${jars_short[@]/#/autoupdate-} )

	jars_short=( "" "-bridge" "-commons" )
	jars+=( ${jars_short[@]/#/bugtracking} )

	jars_short=(
		browser execution ide io-ui kit multitabs multitabs-project
		multiview netigso network osgi output2 windows ui
	)
	jars+=( ${jars_short[@]/#/core-} )

	jars_short=( api types )
	jars+=( ${jars_short[@]/#/csl-} )

	jars_short=( editor lib model prep visual )
	jars+=( ${jars_short[@]/#/css-} )

	jars_short=( nativeexecution nativeexecution-nb terminal )
	jars+=( ${jars_short[@]/#/dlight-} )

	jars_short=(
		actions bookmarks bracesmatching breadcrumbs codetemplates
		completion deprecated-pre65formatting document errorstripe
		errorstripe-api fold fold-nbui global-format guards indent
		indent-support lib lib2 macros mimelookup mimelookup-impl
		plain plain-lib search settings settings-lib settings-storage
		structure tools-storage util
	)
	jars+=( ${jars_short[@]/#/editor-} )

	jars_short=( browser execution execution-base execution-impl )
	jars+=( ${jars_short[@]/#/ext} )

	jars_short=( "" "-nb" "-refactoring" )
	jars+=( ${jars_short[@]/#/form} )

	jars_short=( codecoverage testrunner testrunner-ui )
	jars+=( ${jars_short[@]/#/gsf-} )

	jars_short=( "" "-custom" "-editor" "-editor-lib" "-lexer" "-parser" )
	jars+=( ${jars_short[@]/#/html} )

	jars_short=( metadata metadata-model-support persistenceapi )
	jars+=( ${jars_short[@]/#/j2ee-} )

	jars_short=(
		api-common completion debug editor editor-base editor-lib
		freeform graph guards hints hints-declarative hints-legacy-spi
		hints-ui kit lexer metrics module-graph navigation platform
		platform-ui preprocessorbridge project project-ui source
		source-ant source-base source-compat8 source-queriesimpl
		sourceui testrunner testrunner-ant testrunner-ui
	)
	jars+=( ${jars_short[@]/#/java-} )

	jars_short=( deploy platform profiles project )
	jars+=( ${jars_short[@]/#/java-j2se} )

	jars_short=( nbjavac terminalemulator uihandler )
	jars+=( ${jars_short[@]/#/lib-} )

	jars_short=(
		antlr3-runtime antlr4-runtime freemarker jsch-agentproxy git
	)
	jars+=( ${jars_short[@]/#/libs-} )

	jars_short=( "" "-linux" -"nio2" "-ui" )
	jars+=( ${jars_short[@]/#/masterfs} )

	jars_short=( dirchooser outline plaf tabcontrol )
	jars+=( ${jars_short[@]/#/o-n-swing-} )

	jars_short=(
		actions awt compat dialogs execution explorer filesystems-nb
		io loaders nodes options text windows
	)
	jars+=( ${jars_short[@]/#/openide-} )

	jars_short=( api editor java keymap )
	jars+=( ${jars_short[@]/#/options-} )

	jars_short=( api indexing lucene nb ui )
	jars+=( ${jars_short[@]/#/parsing-} )

	jars_short=(
		"-ant" "-ant-ui" api api-nb "-indexingbridge" "-libraries"
		"-libraries-ui" "-spi-intern" "-spi-intern-impl" ui uiapi
		uiapi-base ui-buildmenu
	)
	jars+=( ${jars_short[@]/#/project} )

	jars_short=( api java )
	jars+=( ${jars_short[@]/#/refactoring-} )

	jars_short=( "" "-apimodule" )
	jars+=( ${jars_short[@]/#/spellchecker} )

	jars_short=(
		actions editor-hints editor-hints-projects java-hints
		navigator palette quicksearch tasklist viewmodel
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

	jars_short=( browser-api common common-ui indent )
	jars+=( ${jars_short[@]/#/web-} )

	jars_short=(
		"" "-axi" "-catalog" "-catalog-ui" "-core" "-lexer" "-multiview"
		"-retriever" "-schema-model" "-schema-completion" "-tax"
		"-text" "-tools" "-tools-java" "-xam" "-xdm"
	)
	jars+=( ${jars_short[@]/#/xml} )

	jars+=(
		classfile diff editor favorites git i18n ide ide-kit gototest
		javahelp jumpto junit junit-ui keyring lexer lexer-nbbridge
		localhistory localtasks mylyn-util o-apache-tools-ant-module
		progress-ui properties properties-syntax queries sampler
		sendopts server settings team-commons team-ide terminal
		terminal-nb uihandler updatecenters whitelist xsl
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
