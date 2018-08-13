# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/qdox:0
"

inherit java-pkg

DESCRIPTION="A tool which helps you work with JSR175 annotations"
HOMEPAGE="https://github.com/codehaus/${PN}"
SRC_URI="https://repo1.maven.org/maven2/${PN}/${PN}/${PV}/${P}.zip"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" app-arch/unzip"

JAVAC_ARGS=" --add-modules jdk.javadoc "
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
