# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="RSyntaxTextArea"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/bobbylight/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A syntax highlighting, code folding text editor for Java Swing applications"
HOMEPAGE="https://bobbylight.github.io/RSyntaxTextArea/"
LICENSE="robert-futrell"
SLOT="0"

S="${WORKDIR}/${MY_S}"
