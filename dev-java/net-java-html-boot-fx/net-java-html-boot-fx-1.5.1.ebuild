# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

MY_PN="${PN//-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}-sources"

DESCRIPTION="A presentation provider to show JavaFX WebView"
SRC_URI="https://repo1.maven.org/maven2/org/netbeans/html/${MY_PN}/${PV}/${MY_P}.jar"
SLOT="0"
S="${WORKDIR}"

CP_DEPEND="
	~dev-java/net-java-html-${PV}:${SLOT}
	~dev-java/net-java-html-boot-${PV}:${SLOT}
	dev-java/netbeans-openide-util-lookup:9
"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

src_unpack() {
	default
}

src_prepare() {
	java-utils-2_src_prepare
}
