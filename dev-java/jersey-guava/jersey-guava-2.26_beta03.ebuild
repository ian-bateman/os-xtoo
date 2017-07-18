# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN:0:6}"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Jersey RESTful Web Services in Java Core Common"
HOMEPAGE="https://${MY_PN}.java.net/"
SRC_URI="https://repo1.maven.org/maven2/org/glassfish/${PN:0:6}/bundles/repackaged/${PN}/${MY_PV}/${PN}-${MY_PV}-sources.jar"

LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/jsr305:0"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

PATCHES=(
	#https://github.com/google/guava/commit/f4aa25e74a9466c2f93a2147a7cf9b01850dd41f
	"${FILESDIR}/${PN}-${SLOT}-java-1.8.patch"
)
