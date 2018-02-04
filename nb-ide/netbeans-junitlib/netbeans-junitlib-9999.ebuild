# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"

RDEPEND="
	dev-java/junit:5
	>=virtual/jre-9
"

JAVA_NO_SRC=0
