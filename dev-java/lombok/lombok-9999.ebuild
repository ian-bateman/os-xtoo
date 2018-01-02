# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/rzwitserloot/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Very spicy additions to the Java programming language."
HOMEPAGE="https://projectlombok.org/"
LICENSE="Apache-2.0"
SLOT="0"

ECLIPSE_SLOT="4.7"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/cmdreader:0
	dev-java/eclipse-jdt-core:${ECLIPSE_SLOT}
	dev-java/eclipse-jdt-ui:${ECLIPSE_SLOT}
	dev-java/eclipse-jface-text:${ECLIPSE_SLOT}
	dev-java/eclipse-core-jobs:${ECLIPSE_SLOT}
	dev-java/eclipse-core-resources:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/freemarker:2.3
	dev-java/java2html:0
	dev-java/lombok-patcher:0
	dev-java/markdownj:0
	dev-java/osgi-core-api:6
	dev-java/spi:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P}"

# Hack patch, allows build doubt it is usable/working runtime?
PATCHES=( "${FILESDIR}/javac-type.patch" )

JAVA_SRC_DIR="src"
JAVA_GENTOO_CLASSPATH_EXTRA="${JAVA_HOME}/lib/tools.jar"

java_prepare() {
	rm -r src/{javac-only-stubs,stubsstubs,testAP,useTestAP} \
		|| die "Failed to remove sources not to be included"
}

src_compile() {
	export JAVA_GENTOO_CLASSPATH_EXTRA="${JAVA_HOME}/lib/tools.jar"
	java-pkg-simple_src_compile
}
