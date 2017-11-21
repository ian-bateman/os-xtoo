# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:6}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/commons-logging:0
	dev-java/javassist:3
	dev-java/jctools-core:2
	dev-java/log4j:0
	dev-java/log4j-api:0
	dev-java/slf4j-api:0
"

if [[ "${SLOT}" != "4.0" ]] ; then
	GROOVY_DEPS="
		dev-java/ant-core:0
		dev-java/antlr:0
		dev-java/commons-cli:1
		dev-java/groovy:0
		dev-java/groovy-ant:0
	"
fi

DEPEND="${GROOVY_DEPS}
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVAC_ARGS="--add-exports jdk.unsupported/sun.misc=ALL-UNNAMED"

if [[ "${SLOT}" != "4.0" ]] ; then

	PATCHES=(
		"${FILESDIR}/codegen_groovy.patch"
	)

	java_prepare() {
		# Unable to use groovy due to classpath issues
		# the following does not work, but should
		# groovy -cp "$(java-pkg_getjars --build-only groovy-ant)"
		java -cp "$(java-pkg_getjars --build-only ant-core,antlr,asm-4,commons-cli-1,groovy,groovy-ant)" \
			groovy.ui.GroovyMain src/main/script/codegen.groovy \
			|| die "groovy codegen failed"
	}
fi
