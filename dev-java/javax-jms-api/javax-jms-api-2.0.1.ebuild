# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN/x-j/x.j}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java Message Service"
HOMEPAGE="https://java.net/projects/jms-spec/pages/Home"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:3}/${MY_PN}/${PV}/${MY_P}-sources.jar"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

DEPEND="app-arch/unzip
	>=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"
