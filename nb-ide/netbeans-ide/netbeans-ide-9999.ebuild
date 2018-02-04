# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

DEPEND=">=virtual/jre-9"
RDEPEND=">=virtual/jre-9"

S+="/projectopener"
JAVAC_ARGS="--add-modules java.jnlp"
