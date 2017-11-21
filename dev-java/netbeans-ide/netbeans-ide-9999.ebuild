# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jre-9"
RDEPEND=">=virtual/jre-9"

JAVA_SRC_DIR="projectopener/src"
JAVAC_ARGS="--add-modules java.jnlp"
