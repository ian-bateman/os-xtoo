# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/madflow/${PN}"

inherit java-netbeans

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="A NetBeans IDE plugin which adds Markdown support"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

NB_SLOT="9"
PARBOILED_SLOT="0"

CP_DEPEND="
	dev-java/parboiled-core:${PARBOILED_SLOT}
	dev-java/parboiled-java:${PARBOILED_SLOT}
	dev-java/pegdown:0
	nb-ide/netbeans-api-annotations-common:${NB_SLOT}
	nb-ide/netbeans-api-templates:${NB_SLOT}
	nb-ide/netbeans-csl-api:${NB_SLOT}
	nb-ide/netbeans-csl-types:${NB_SLOT}
	nb-ide/netbeans-core-multiview:${NB_SLOT}
	nb-ide/netbeans-editor:${NB_SLOT}
	nb-ide/netbeans-editor-codetemplates:${NB_SLOT}
	nb-ide/netbeans-editor-completion:${NB_SLOT}
	nb-ide/netbeans-editor-document:${NB_SLOT}
	nb-ide/netbeans-editor-fold:${NB_SLOT}
	nb-ide/netbeans-editor-errorstripe:${NB_SLOT}
	nb-ide/netbeans-editor-errorstripe-api:${NB_SLOT}
	nb-ide/netbeans-editor-lib:${NB_SLOT}
	nb-ide/netbeans-editor-lib2:${NB_SLOT}
	nb-ide/netbeans-editor-mimelookup:${NB_SLOT}
	nb-ide/netbeans-editor-util:${NB_SLOT}
	nb-ide/netbeans-lexer:${NB_SLOT}
	nb-ide/netbeans-openide-awt:${NB_SLOT}
	nb-ide/netbeans-openide-filesystems:${NB_SLOT}
	nb-ide/netbeans-openide-loaders:${NB_SLOT}
	nb-ide/netbeans-openide-nodes:${NB_SLOT}
	nb-ide/netbeans-openide-text:${NB_SLOT}
	nb-ide/netbeans-openide-util:${NB_SLOT}
	nb-ide/netbeans-openide-util-lookup:${NB_SLOT}
	nb-ide/netbeans-openide-util-ui:${NB_SLOT}
	nb-ide/netbeans-openide-windows:${NB_SLOT}
	nb-ide/netbeans-options-api:${NB_SLOT}
	nb-ide/netbeans-parsing-api:${NB_SLOT}
	nb-ide/netbeans-parsing-indexing:${NB_SLOT}
	nb-ide/netbeans-queries:${NB_SLOT}
	nb-ide/netbeans-spellchecker-apimodule:${NB_SLOT}
	nb-ide/netbeans-spi-navigator:${NB_SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

src_prepare() {
	local f

	for f in Export Preview; do
		sed -i -e "s|private void printAttribute|protected void printAttribute|" \
			src/flow/netbeans/markdown/${f}Serializer.java \
			|| die "Failed to sed/fix weaker privileges"
	done

	java-netbeans_src_prepare
}
