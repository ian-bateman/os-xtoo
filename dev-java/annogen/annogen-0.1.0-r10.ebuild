# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A tool which helps you work with JSR175 annotations"
HOMEPAGE="https://github.com/codehaus/${PN}"
SRC_URI="https://repo1.maven.org/maven2/${PN}/${PN}/${PV}/${P}.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/qdox:1.6
"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

JAVA_NEEDS_TOOLS=1
JAVA_RM_FILES=(
	examples
	org/codehaus/annogen/view/MirrorAnnoViewer.java
	org/codehaus/annogen/override/MirrorElementIdPool.java
)

src_unpack() {
	default
	unzip -o -q "${S}/${PN}-src-${PV}.zip" \
		|| die "Failed to unpack bundled sources"
}
