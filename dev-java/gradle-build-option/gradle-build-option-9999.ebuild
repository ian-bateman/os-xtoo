# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-lang:2
	dev-java/jsr305:0
	~dev-java/gradle-cli-${PV}:${SLOT}
"

inherit gradle
