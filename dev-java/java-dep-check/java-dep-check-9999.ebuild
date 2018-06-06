# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/asm:6
	dev-java/commons-cli:1
"

inherit java-pkg

DESCRIPTION="Java Dependency checker"
HOMEPAGE="${BASE_URI}"
LICENSE="GPL-3"
SLOT="0"

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN} --main Main
}
