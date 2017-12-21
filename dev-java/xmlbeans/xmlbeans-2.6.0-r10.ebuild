# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="An XML-Java binding tool - Retired EOL project"
HOMEPAGE="https://${PN}.apache.org/"
SRC_URI="https://archive.apache.org/dist/${PN}/source/${P}-src.tgz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/annogen:0
	dev-java/ant-core:0
	dev-java/piccolo:0
	dev-java/saxon:0
	dev-java/xml-commons-resolver:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}"/piccolo.patch
	"${FILESDIR}"/SchemaCompiler.java.patch
)

JAVA_PKG_NO_CLEAN=1

JAVAC_ARGS+=" --add-modules java.xml "

java_prepare() {
	local f files files1 my_cp

	rm -r src/xmlpublic/javax src/store/org/w3c \
		|| die "Failed to remove java 9 dup classes and jam"

	sed -i -e "s|NodeWrapper|DOMNodeWrapper|g" \
		-e "s|om.VirtualNode|tree.wrapper.VirtualNode|" \
		-e "s|value.Value|om.SequenceTool|" \
		-e "s|Value.convert|SequenceTool.convert|" \
		-e "s|xpe.declare|xpe.getStaticContext().declare|" \
		-e "/setDOMLevel/d" \
		src/xpath_xquery/org/apache/xmlbeans/impl/xpath/saxon/XBeansXPath.java \
		|| die "Failed to sed/update saxon"

	sed -i -e "/setDOMLevel/d" \
		-e 's|(contextVar,|(new StructuredQName("", "",contextVar),|' \
		-e 's|(key,|(new StructuredQName("", "",key), (Sequence)|' \
		-e 's|, paramObject|, (paramObject)|' \
		-e "31iimport net.sf.saxon.om.Sequence;" \
		-e "31iimport net.sf.saxon.om.StructuredQName;" \
		src/xpath_xquery/org/apache/xmlbeans/impl/xquery/saxon/XBeansXQuery.java \
		|| die "Failed to sed/update saxon"

	my_cp="external/lib/oldxbean.jar"
	files=(
		xmlschema/schema/XML
		xsdschema/schema/XMLSchema
		toolschema/ltgfmt
		toolschema/substwsdl
		toolschema/xsdownload
		configschema/schema/xmlconfig
	)
	for f in "${files[@]}"; do
		java -cp ${my_cp} org.apache.xmlbeans.impl.tool.SchemaCompiler \
			-srconly -src src \
			src/${f}.xsd \
			src/${f}.xsdconfig \
			|| die "Failed to generate java sources via bootstrap"
	done

	files=( BindingConfig InterfaceExtension PrePostExtension UserType )
	files=( ${files[@]/#/xmlconfig/org/apache/xmlbeans/impl/config/} )
	files=( ${files[@]/%/Impl} )
	files1=( reflect/Reflect javadoc/Javadoc )
	files1=( ${files1[@]/#/jamsupport/org/apache/xmlbeans/impl/jam/internal/} )
	files1=( ${files1[@]/%/TigerDelegateImpl_150} )
	files=( ${files[@]} ${files1[@]} )
	for f in "${files[@]}"; do
		sed -i -e "s|apache.xmlbeans.impl.jam|codehaus.jam|g" \
			"src/${f}.java" \
			|| die "Failed to sed jam imports"
	done

	echo '#!/bin/bash
cp="$(java-config -p piccolo,xmlbeans)"
java="$(java-config -J)"
"${java}" -Xmx256m -cp "${cp}" org.apache.xmlbeans.impl.tool.SchemaCompiler "$@"' > \
"${S}/bin/scomp" || die "Failed to replace scomp"
}

src_install() {
	java-pkg-simple_src_install
	dobin bin/scomp
}
