# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN:6}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

ASM_SLOT="6"
CLI_SLOT="1"

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
		dev-java/asm:${ASM_SLOT}
		dev-java/commons-cli:${CLI_SLOT}
		dev-java/groovy:0
		dev-java/groovy-ant:0
	"
fi
inherit java-pkg

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"

DEPEND+=" ${GROOVY_DEPS}"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVAC_ARGS="--add-exports jdk.unsupported/sun.misc=ALL-UNNAMED"

if [[ "${SLOT}" != "4.0" ]] ; then

	PATCHES=( "${FILESDIR}/codegen_groovy.patch" )

	java_prepare() {
		# Unable to use groovy due to classpath issues
		# the following does not work, but should
		# groovy -cp "$(java-pkg_getjars --build-only groovy-ant)"
		java -cp "$(java-pkg_getjars --build-only ant-core,antlr,asm-${ASM_SLOT},commons-cli-${CLI_SLOT},groovy,groovy-ant)" \
			groovy.ui.GroovyMain src/main/script/codegen.groovy \
			|| die "groovy codegen failed"
	}
fi
