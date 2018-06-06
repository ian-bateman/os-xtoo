# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source examples"

MY_P="${PN}${PV//./-}"

CP_DEPEND="
	dev-java/axiom-api:0
	dev-java/dom4j:2
	dev-java/icu4j:0
	dev-java/intellij-platform-annotations:0
	dev-java/jdom:0
	dev-java/jdom:2
	dev-java/xom:0
	dev-java/xml-commons-resolver:0
"

inherit java-pkg

DESCRIPTION="The XSLT and XQuery Processor"
HOMEPAGE="https://sourceforge.net/projects/saxon"
SRC_URI="mirror://sourceforge/${PN}/Saxon-HE/${PV%.*.*}/${MY_P}source.zip"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

DEPEND+=" app-arch/unzip"

java_prepare() {
	sed -i -e "s|<Node> atts|<Attribute> atts|" \
		net/sf/saxon/option/dom4j/DOM4JNodeWrapper.java \
		|| die "Failed to sed/fix incompatible types"
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher ${PN}${SLOT}-transform --main net.sf.saxon.Transform
	java-pkg_dolauncher ${PN}${SLOT}-query --main net.sf.saxon.Query
}
