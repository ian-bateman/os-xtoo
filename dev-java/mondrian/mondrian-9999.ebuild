# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}-R"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/pentaho/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="OLAP server to analyze large quantities of data in real-time"
HOMEPAGE="http://${PN}.pentaho.com/"
LICENSE="EPL-1.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/commons-collections:0
	dev-java/commons-dbcp:2
	dev-java/commons-io:0
	dev-java/commons-logging:0
	dev-java/commons-math:2
	dev-java/commons-pool:2
	dev-java/commons-vfs:2
	dev-java/eigenbase-xom:0
	dev-java/eigenbase-properties:0
	dev-java/eigenbase-resgen:0
	dev-java/log4j:0
	dev-java/olap4j:0
	dev-java/olap4j-xmlaserver:0
	dev-java/xalan:0
	dev-java/xerces:2
	java-virtuals/servlet-api:2.4
"

JDK_VERSION="9"

DEPEND="${CP_DEPEND}
	dev-java/ant-core:0
	>=virtual/jdk-${JDK_VERSION}"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-${JDK_VERSION}"

S="${WORKDIR}/${MY_S}/"

JAVAC_ARGS+=" --add-modules=java.xml "

PATCHES=( "${FILESDIR}/commons-pool2.patch" )

java_prepare() {
	# generate java files
	local f files my_cp my_path
	my_path="${S}src/main/mondrian/parser/"
	if [[ -d "${S}src/main/javacc" ]]; then
		my_path="${my_path/n\/m/n/javacc/m}"
	fi
	javacc -JDK_VERSION="${JDK_VERSION}" \
		-OUTPUT_DIRECTORY="${my_path/cc/}" "${my_path}MdxParser.jj" \
		|| die "javacc ${my_path}MdxParser.jj failed"

	# compile class to generate other java files
	ejavac -cp $(jem -p eigenbase-properties) \
		"${S}src/main/java/mondrian/util/PropertyUtil.java" \
		|| die "Failed to compile PropertyUtil.java"

	# generate more java files
	java -cp "${S}src/main/java" mondrian.util.PropertyUtil \
		|| die "Failed to generate files via mondrian.util.PropertyUtil"

	f=mondrian/olap/MondrianProperties.java
	# move file or sed PropertyUtil
	mv "${S}/target/generated-sources/prop/${f}" \
		"${S}/src/main/java/${f}" \
		|| die "Failed to move generated MondrianProperties.java"

	# compile as needed by MondrianResource.xml (z for replacement)
	files=(	"zMondrianException.java"
		"zResultLimitExceededException.java"
		"zInvalidHierarchyException.java"
		"zResourceLimitExceededException.java"
		"zNativeEvaluationUnsupportedException.java"
		"zQueryCanceledException.java"
		"zQueryTimeoutException.java"
	)
	files=( ${files[@]/z/"${S}"src\/main\/java\/mondrian\/olap\/} )
	ejavac ${files[@]} || die "Failed to pre-compile exceptions"

	# locales needs to be system
	my_cp="$(jem -p ant-core,eigenbase-resgen,eigenbase-xom)"
	java -cp "${my_cp}:${S}src/main/java" \
		org.eigenbase.resgen.ResourceGen \
			-locales "${L10N// /,}" \
			-srcdir "${S}src/main/java" \
			-style "functor" \
			mondrian/resource/MondrianResource.xml \
	|| die "Failed to generate MondrianResource.java via eigenbase-resgen"

	files=(
		xom/mondrian/olap/Mondrian3Schema
		xom/mondrian/olap/MondrianSchema
		xom/mondrian/rolap/aggmatcher/DefaultRulesSchema
		xom/mondrian/xmla/DataSourcesConfig
	)
	# generate more java files
	for f in "${files[@]}"; do
		einfo "${f}"
		java -cp "${my_cp}:." \
			org.eigenbase.xom.MetaGenerator \
			"${S}src/main/${f}.xml" "${S}src/main/java" \
			|| die "Failed to process ${f}.xml via eigenbase-xom"
	done

	# upgrade to dbcp2/pool2
	for f in DefaultDataServicesProvider; do
		sed -i -e "s|s.dbcp.|s.dbcp2.|g" \
			-e "s|s.pool.|s.pool2.|g" \
			"${S}src/main/java/mondrian/rolap/${f}.java" \
		|| die "Failed to sed dbcp/pool -> dbcp2/pool2"
	done

	# upgrade to vfs2
	sed -i -e "s|.vfs.|.vfs2.|g" \
		src/main/java/mondrian/spi/impl/ApacheVfsVirtualFileHandler.java \
		|| die "Failed to sed vfs -> vfs2"

	# remove problem files
	rm src/main/java/mondrian/olap4j/FactoryJdbc{3,4}Impl.java \
		|| die "Failed to remove FactoryJdbc{3,4}Impl.java"

	# Create version files, minor version needs fixing
	for f in olap4j/MondrianOlap4jDriver server/MondrianServer; do
		echo "
package mondrian.${f%/*};
class ${f#*/}Version {
	static final String VENDOR = \"Obsidian-Studios, Inc.\";
	static final String NAME = \"${PN}\";
	static final String VERSION = \"${PV}\";
	static final int MAJOR_VERSION = ${PV%%.*};
	static final int MINOR_VERSION = ${PV:2:1};
}
" >> "${S}src/main/java/mondrian/${f}Version.java"
	done
}
