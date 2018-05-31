# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="dev-java/ant-core:0"

inherit java-pkg

DESCRIPTION="Port of HTML Tidy, a HTML syntax checker and pretty printer"
HOMEPAGE="${BASE_URI}"
LICENSE="HTML-Tidy W3C"
SLOT="0"

S="${WORKDIR}/${P}"
