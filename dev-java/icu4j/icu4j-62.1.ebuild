# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PV="${PV/./_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="International Components for Unicode for Java"
HOMEPAGE="https://site.icu-project.org"
SRC_URI="http://download.icu-project.org/files/${PN}/${PV}/${MY_P}-src.jar
	doc? ( http://download.icu-project.org/files/${PN}/${PV}/${MY_P}-docs.jar )"

LICENSE="icu"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip"
