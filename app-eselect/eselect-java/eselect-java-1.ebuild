# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Meta package installs nothing"
HOMEPAGE="https://github.com/Obsidian-StudiosInc/os-xtoo"
LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	!app-eselect/eselect-ecj
	!app-eselect/eselect-maven
	!<dev-java/java-config-2.2
	app-admin/eselect
"
