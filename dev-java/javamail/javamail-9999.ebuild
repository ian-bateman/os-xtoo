# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JavaMail API Reference Implementation"
HOMEPAGE="https://javaee.github.io/javamail/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

DEPEND=">=virtual/jdk-1.9"

RDEPEND=">=virtual/jre-1.9"

S="${WORKDIR}/${MY_S}/mail"

JAVAC_ARGS="--add-modules java.activation"
JAVADOC_ARGS="${JAVAC_ARGS}"
JAVA_SRC_DIR="
	src/main/java
	src/main/resources
"
