# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/annogen:0
	dev-java/ant-core:0
	dev-java/piccolo:0
	dev-java/saxon:0
"

inherit java-pkg

DESCRIPTION="An XML-Java binding tool - Retired EOL project"
HOMEPAGE="https://${PN}.apache.org/"
SRC_URI="https://archive.apache.org/dist/${PN}/source/${P}-src.tgz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}"/piccolo.patch
	"${FILESDIR}"/SchemaCompiler.java.patch
	"${FILESDIR}"/SchemaTypeSystemImpl.java.patch
)

JAVA_PKG_NO_CLEAN=1
JAVA_RES_RM_DIR=0

java_prepare() {
	local c f files files1 my_cp name

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
	c="classes/schemaorg_apache_xmlbeans/system"
	mkdir -p "${c}" || die "Failed to mkdir ${ec}"
	for f in "${files[@]}"; do
		case ${f%%/*} in
			config*) name="CONFIG";;
			tool*) name="TOOLS";;
			xml*) name="LANG";;
			xsd*) name="SCHEMA";;
		esac
		name="sXML${name}"
		java -cp ${my_cp} org.apache.xmlbeans.impl.tool.SchemaCompiler \
			-javasource "1.6" \
			-name "${name}" -noann \
			-d src/resources/ \
			-src src/generated \
			src/${f}.xsd \
			src/${f}.xsdconfig \
			|| die "Failed to generate java sources via bootstrap"
		if [[ ! -d "${c}/${name}" ]]; then
			mkdir "${c}/${name}" \
				|| die "Failed to mkdir ${c}/${name}"
		fi
		mv {${c/classes/src/resources},${c}}/${name}/TypeSystemHolder.class \
			|| die "Failed to mv ${name}/TypeSystemHolder.class"
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

	sed -i -e '41,50d' src/xmlpublic/org/apache/xmlbeans/XmlBeans.java \
		|| die "Failed to sed/fix static returning null"

	echo '#!/bin/bash
cp="$(jem -p piccolo,xmlbeans)"
java="$(jem -J)"
"${java}" -Xmx256m -cp "${cp}" org.apache.xmlbeans.impl.tool.SchemaCompiler "$@"' > \
"${S}/bin/scomp" || die "Failed to replace scomp"
}

src_compile() {
	JAVA_NO_JAR=0
	java-pkg-simple_src_compile
	mv target/classes/org/apache/xmlbeans/impl/schema/TypeSystemHolder.{class,template} \
		|| die "Failed to mv TypeSystemHolder.{class,template}"
	mv classes/schemaorg_apache_xmlbeans target/classes \
		|| die "Failed to mv generated classes from prepare"
	java-pkg-simple_create-jar target/classes
}

src_install() {
	java-pkg-simple_src_install

	dobin bin/scomp
#	java-pkg_dolauncher scomp \
#		--main org.apache.xmlbeans.impl.tool.SchemaCompiler \
#		--pkg_args "-Xmx256m"
}
