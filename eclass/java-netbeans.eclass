# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-netbeans.eclass
# @MAINTAINER: William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR: William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Netbeans IDE common code

if [[ -z ${_JAVA_NETBEANS_ECLASS} ]]; then
_JAVA_NETBEANS_ECLASS=1

MY_PN="incubator-${PN%%-*}"
MY_PV="${PV//_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD//-/.}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
	inherit git-r3
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Netbeans IDE"
HOMEPAGE="https://netbeans.org"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"
S="${WORKDIR}/${MY_S}/${MY_MOD}"

EXPORT_FUNCTIONS src_unpack src_prepare src_compile src_install

# @FUNCTION: java-netbeans_src_unpack
# @DESCRIPTION:
# Only unpack whats needed
java-netbeans_src_unpack() {
	if [[ "${PN}" != "${PN%%-*}" ]]; then
		local tgz
		tgz="${MY_P}.tar.gz"
		echo ">>> Unpacking ${tgz} to ${PWD}"
		tar -xzf "${DISTDIR}/${tgz}" \
			"${MY_P}/${MY_MOD}/" -C "${WORKDIR}" \
			|| die "Failed to unpack ${DISTDIR}/${tgz}"
	else
		default
	fi
}

# @FUNCTION: java-netbeans_src_prepare
# @DESCRIPTION:
# Prepare sources
java-netbeans_src_prepare() {
	JAVA_RES_DIR="resources"
	mkdir -p ${JAVA_RES_DIR} ||  die "Failed to make resorces dir"
	if [[ -d src/META-INF ]]; then
		mv src/META-INF ${JAVA_RES_DIR} || die "Failed to move META-INF"
	else
		mkdir -p ${JAVA_RES_DIR}/META-INF \
			|| die "Failed to make META-INF dir"
	fi

	# manifest
	if [[ -f manifest.mf ]]; then
		mv manifest.mf ${JAVA_RES_DIR}/META-INF/MANIFEST.MF \
			|| die "Failed to move manifest"
		sed -i -e '/OpenIDE-Module-Implementation-Version/d' \
			-e '2iOpenIDE-Module-Build-Version: '${PV}'-os-xtoo' \
			-e '2iOpenIDE-Module-Implementation-Version: '${PV}'-os-xtoo' \
			"${JAVA_RES_DIR}/META-INF/MANIFEST.MF" \
			|| die "Failed to append to manifest"
	fi

	# copy resources need to preserve paths? maybe delete sources?
	cp -r src/* ${JAVA_RES_DIR} || die "Failed to copy resources"
	find ${JAVA_RES_DIR} -name '*.java' -delete \
		|| die "Failed to delete sources from resources"

	java-utils-2_src_prepare
}

# @FUNCTION: java-netbeans_src_compile
# @DESCRIPTION:
# Wrapper for java-pkg-simple_src_compile to set common JAVAC_ARGS
java-netbeans_src_compile() {
	local pkg procs

	pkg="org.netbeans.modules.openide"
	procs="${NB_PROC}"
	JAVAC_ARGS+=" -parameters"

	# Generate Bundle.*
	[[ -n ${NB_BUNDLE} ]] &&
		procs+=",${pkg}.util.NbBundleProcessor"

	[[ "${CP_DEPEND}" == *api-intent* ]] &&
		procs+=",${pkg/openide/}intent.OpenUriHandlerProcessor"

#	[[ "${CP_DEPEND}" == *openide-awt* ]] &&
#		procs+=",${pkg}.awt.ActionProcessor"

	[[ "${CP_DEPEND}" == *openide-filesystems* ]] &&
		procs+=",${pkg}.filesystems.declmime.MIMEResolverProcessor"

	[[ "${CP_DEPEND}" == *openide-loader* ]] &&
		procs+=",${pkg}.loaders.DataObjectFactoryProcessor"

	[[ "${CP_DEPEND}" == *openide-nodes* ]] &&
		procs+=",${pkg}.nodes.NodesAnnotationProcessor"

	if [[ "${CP_DEPEND}" == *"openide-util-${PV}"* ]]; then
		procs+=",${pkg}.util.NamedServiceProcessor"
		procs+=",${pkg}.util.ServiceProviderProcessor"
	fi

	[[ "${CP_DEPEND}" == *openide-nodes* ]] &&
		procs+=",${pkg}.nodes.NodesAnnotationProcessor"

	if [[ -n ${procs} ]]; then
		procs=${procs#,}
		procs=${procs%,}
		JAVAC_ARGS+=" --add-modules java.xml.ws.annotation "
		JAVAC_ARGS+="-processor ${procs}"
		# for resources
		JAVA_CLASSPATH_EXTRA="src/"
	fi

	java-pkg-simple_src_compile
}

# @FUNCTION: java-netbeans_src_install
# @DESCRIPTION:
# Wrapper for java-pkg-simple_src_install to install common stuff
# outside of the main jar
java-netbeans_src_install() {
	java-pkg-simple_src_install
	if [[ -f module-auto-deps.xml ]]; then
		local dir
		dir="/usr/share/${PN%%-*}-${SLOT}/config/ModuleAutoDeps/"
		insinto "${dir}"
		newins module-auto-deps.xml org-${PN}.xml
	fi
}

# fi _JAVA_NETBEANS_ECLASS
fi
