# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="Flexible generator for barcodes written in Java"
HOMEPAGE="https://${PN}.sourceforge.net"
SRC_URI="https://repo1.maven.org/maven2/net/sf/${PN}/${PN}/${PV}/${P}-sources.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/avalon-framework:4.2
	dev-java/commons-cli:1
	java-virtuals/servlet-api:4.0
"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"
