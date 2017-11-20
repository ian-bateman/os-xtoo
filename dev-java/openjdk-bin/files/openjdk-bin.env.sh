# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

VERSION="Open JDK ${PV}"
JAVA_HOME="${EPREFIX}/opt/${P}"
JDK_HOME="${EPREFIX}/opt/${P}"
JAVAC="\${JAVA_HOME}/bin/javac"
PATH="\${JAVA_HOME}/bin"
ROOTPATH="\${JAVA_HOME}/bin"
LDPATH="\${JAVA_HOME}/lib/"
MANPATH="${EPREFIX}/opt/${P}/man"
PROVIDES_TYPE="JDK JRE"
PROVIDES_VERSION="${SLOT}"
BOOTCLASSPATH="\${JAVA_HOME}/lib/modules"
GENERATION="2"
ENV_VARS="JAVA_HOME JDK_HOME JAVAC PATH ROOTPATH LDPATH MANPATH"
