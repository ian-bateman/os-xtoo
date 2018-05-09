# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="http://www2.cs.tum.edu/projects/cup"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git@versioncontrolseidl.in.tum.de:parsergenerators/cup.git"
	SLOT="${PV}"
else
	if [[ ${PV} == 0.10* ]]; then
		MY_PN="${PN/-/_}"
		MY_PV="v${PV##*.}"
		MY_P="${MY_PN}_${MY_PV}"
		S="${WORKDIR}/${MY_PN}"
	else
		MY_PN="${PN}"
		MY_PV="${PV%%_*}-${PV##*p}"
		MY_PV="${MY_PV##*.}"
		MY_P="${MY_PN}-src-${MY_PV}"
	fi
	SRC_URI="${BASE_URI}/releases/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	SLOT="${PV:3:1}"
fi

inherit java-pkg

DESCRIPTION="CUP Parser Generator"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-2"

if [[ ${SLOT} != 0 ]]; then
	CP_DEPEND="dev-java/ant-core:0"
	DEPEND="${CP_DEPEND}
		dev-java/java-cup:0
		dev-java/jflex:0"
fi
DEPEND+="
	!dev-java/javacup:*
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	if [[ ${SLOT} != 0 ]]; then
		jflex -d src/java_cup flex/Lexer.jflex \
			|| die "Failed to generate java via jflex"
		cd src/java_cup || die "Failed to change directory to src"
		javacup -interface ../../cup/parser.cup \
			|| die "Failed to generate java via javacup"
		sed -i -e "s|),csf|)|" Main.java \
			|| die "Failed to sed/fix generated code"
	fi
}

src_install() {
	local my_pn

	my_pn=${PN/-/}
	[[ ${SLOT} != 0 ]] && my_pn+="-${SLOT}"
	java-pkg-simple_src_install
	java-pkg_dolauncher ${my_pn} --main ${PN/-/_}.Main
}
