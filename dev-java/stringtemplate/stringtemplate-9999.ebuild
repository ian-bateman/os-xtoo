# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/antlr/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Template engine"
HOMEPAGE="https://www.stringtemplate.org/"
LICENSE="BSD"

ANTLR_SLOT="3"

CP_DEPEND="dev-java/antlr:${ANTLR_SLOT}"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	for f in STParser Group CodeGenerator; do
		antlr${ANTLR_SLOT} \
			-fo src/org/stringtemplate/v4/compiler/{,${f}.g} \
			|| die "Failed to generate java via antlr${ANTLR_SLOT}"
	done

	sed -i -e "s|insertChild(0, |addChild(|" \
		src/org/stringtemplate/v4/gui/JTreeScopeStackModel.java \
		|| die "Failed to sed/fix method"

	sed -i -e "s|= r.getTree|= (CommonTree)r.getTree|" \
		src/org/stringtemplate/v4/compiler/Compiler.java \
		|| die "Failed to sed/fix cast"
}
