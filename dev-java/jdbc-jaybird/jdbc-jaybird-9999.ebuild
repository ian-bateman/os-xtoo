# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source examples test"

MY_PN="${PN/jdbc-/}"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV/beta/beta-}"

BASE_URI="https://github.com/FirebirdSQL/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_PV}"
fi

inherit eutils java-pkg-2 java-ant-2 ${ECLASS}

DESCRIPTION="JDBC Type 2 and 4 drivers for Firebird SQL server"
HOMEPAGE="https://jaybirdwiki.firebirdsql.org/"
LICENSE="LGPL-2"
SLOT="0"
IUSE="jni"

CP_DEPEND="
	>=dev-java/antlr-4.7:4
	>=dev-java/jna-4.4.0:4
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	dev-java/glassfish-connector-api:0
	>=virtual/jdk-1.8
	jni? ( dev-java/cpptasks )
	test? (
		dev-java/ant-junit:0
		dev-java/junit:4
	)
"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# prevent test/sources/javadoc from being built unless wanted
	sed -i -e 's|name="jar-test" depends="compile"|name="jar-test" depends="compile" if="tests"|' \
		"${S}/build/archive.xml" || die
	sed -i -e 's|name="compile-examples"|name="compile-examples" if="examples"|' \
		-e 's|,set-jdbc-42-test"|,set-jdbc-42-test" if="tests"|' \
		"${S}/build/compile.xml" || die

	# JAVA_ANT_ENCODING doesn't work because it doesn't like entities
	java-ant_xml-rewrite -f build.xml -c -e javac -a encoding -v ISO-8859-1

	cd "${S}/src/lib/"

	java-pkg_jar-from --build-only glassfish-connector-api \
		glassfish-connector-api.jar connector-api-1.5.jar

	java-pkg_jar-from --build-only jna-4 jna.jar jna-4.4.0.jar
	java-pkg_jar-from --build-only antlr-4 antlr-runtime.jar \
		antlr-runtime-4.7.jar

	# the build.xml unpacks this and uses stuff
	touch empty
	jar cf mini-j2ee.jar empty
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="jars"
EANT_DOC_TARGET="javadocs"

src_compile() {
	use jni && ANT_TASKS="cpptasks"

	# This is nonsense, I know, but it works.
	if use test; then
		EANT_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4"
	fi

	java-pkg-2_src_compile $(use test && echo "-Dtests=true") \
		$(use jni && echo "compile-native")
}

src_install() {
	cd "${S}/output/lib/"
	java-pkg_newjar ${MY_PN}-${MY_PV}.jar ${PN}.jar

	for jar in full; do
		java-pkg_newjar ${MY_PN}-${jar}-${MY_PV}.jar \
			${MY_PN}-${jar}.jar || \
			die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	done
	if use test; then
		java-pkg_newjar ${MY_PN}-test-${MY_PV}.jar \
			${MY_PN}-${jar}.jar || \
			die "java-pkg_newjar ${MY_PN}-${jar}.jar failed"
	fi

	if use jni; then
		cd "${S}/output/native"
		sodest="/usr/lib/"
		local so_arch
		if use amd64; then
			so_arch="x64"
		elif use x86; then
			so_arch="x86"
		fi
		java-pkg_doso libjaybird22_${so_arch}.so || die \
			"java-pkg_doso ${sodest}libjaybird22.so failed"
	fi

	cd "${S}"

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die "installing examples failed"
	fi

	use source && java-pkg_dosrc "${S}"/src/*/org

	cd "${S}/output"
	use doc && java-pkg_dohtml -r docs/
	dodoc etc/default.mf
}

src_test() {
	#
	# Warning about timeouts without Firebird installed and running Locally
	#
	ewarn "You will experience long timeouts when running junit tests"
	ewarn "without Firebird installed and running locally. The tests will"
	ewarn "complete without Firebird, but network timeouts prolong the"
	ewarn "testing phase considerably."
	ANT_TASKS="ant-junit" eant all-tests-pure-java
}
