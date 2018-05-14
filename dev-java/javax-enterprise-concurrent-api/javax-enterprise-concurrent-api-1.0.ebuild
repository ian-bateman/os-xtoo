# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN//-/.}"
MY_PN="${MY_PN/t.a/t-a}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="JSR 236: Concurrency Utilities for Java EE"
HOMEPAGE="https://java.net/projects/concurrency-ee-spec"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:10}/${PN:17:10}/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="|| ( CDDL GPL-2 )"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="app-arch/unzip"
