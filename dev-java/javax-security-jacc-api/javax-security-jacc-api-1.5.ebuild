# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN//-/.}"
MY_PN="${MY_PN/.ap/-ap}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java Authorization Contract For Containers API"
HOMEPAGE="https://jcp.org/en/jsr/detail?id=115"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:8}/${PN:15:4}/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="java-virtuals/servlet-api:4.0"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
