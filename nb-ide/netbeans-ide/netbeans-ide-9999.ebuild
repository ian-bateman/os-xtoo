# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S+="/projectopener"

JAVA_PKG_FORCE_VM="oracle-jdk-bin-10"
JAVAC_ARGS="--add-modules java.jnlp"
