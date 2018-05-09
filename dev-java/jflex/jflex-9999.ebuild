# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}-de/${PN}"

if [[ ${PV} == *9999* ]]; then
	SLOT="${PV}"
else
	if [[ ${PV} == 1.[4,5]* ]] ; then
		MY_P="release_${PV//./_}"
		MY_PN="JFlex"
		MY_S="${PN}-${MY_P}/${PN}"
		SLOT="0"
	else
		MY_P="v${PV}"
		MY_PN="${PN}"
		MY_S="${P}"
		CP_DEPEND+=" dev-java/java-cup:1"
		SLOT="1"
	fi
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Lexical analyzer generator (also known as scanner generator)"
HOMEPAGE="${BASE_URI}"
LICENSE="BSD-3-clause"

JCUP_SLOT=1
if [[ ${PV} == 1.4* ]]; then
	JAVA_SRC_DIR="src/JFlex"
	JAVA_RES_DIR="resources"
	JCUP_SLOT=0
fi

CP_DEPEND="dev-java/ant-core:0
	dev-java/java-cup:${JCUP_SLOT}"

DEPEND="${CP_DEPEND}
	!=dev-java/jflex-1.6.1:0
	>=virtual/jdk-9"

if [[ ${PV} != 1.4* ]]; then
	DEPEND+=" dev-java/jflex:0"
fi

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	if [[ ${PV} == 1.4* ]]; then
		rm -r src/JFlex/tests || die "Failed to delete tests"
		mkdir -p resources/JFlex \
			|| die "Failed to make resources directory"
		mv src/{skeleton*,JFlex/Messages*} resources/JFlex \
			|| die "Failed to move Message.properties"
	else
		cd  src/main || die || "Failed to change directory"
		rm -r java/java_cup || die "Failed to remove java_cup sources"
		javacup-1 -destdir java -interface \
			-parser LexParse cup/LexParse.cup \
			|| die "Failed to generate java via javacup"

		sed -i -e "/%inputstreamctor false/d" jflex/LexScan.flex \
			|| die "Failed to sed/delete unknown property"

		jflex --nobak --switch -d java \
			--skel jflex/{skeleton.nested,LexScan.flex} \
			|| die "Failed to generate java via jflex"

#		sed -i -e "3626s/else/} else/" java/LexScan.java \
#			|| die "Failed to sed/fix generated LexScan.java"
	fi
}

src_install() {
	local my_pn

	my_pn=${PN}
	[[ ${SLOT} != 0 ]] && my_pn+="-${SLOT}"
	java-pkg-simple_src_install
	java-pkg_dolauncher ${my_pn} --main ${MY_PN}.Main
}
