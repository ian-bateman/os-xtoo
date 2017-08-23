# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2016 Gentoo Foundation

EAPI="6"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An XML-Java binding tool - Retired EOL project"
HOMEPAGE="https://${PN}.apache.org/"
SRC_URI="https://archive.apache.org/dist/${PN}/source/${P}-src.zip"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/annogen:0
	dev-java/ant-core:0
	dev-java/jsr173:0
	dev-java/piccolo:0
	dev-java/saxon:9
	dev-java/xml-commons-resolver:0
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}"/remove-jamsupport.patch
	"${FILESDIR}"/piccolo.patch
	"${FILESDIR}"/jam.patch
	"${FILESDIR}"/SchemaCompiler.java.patch
)

JAVA_PKG_NO_CLEAN=1

java_prepare() {
	# Preserve the old xbean jar, which is required for bootstrapping schemas.
	mv -v external/lib/oldxbean.jar "${T}"/ || die

	# Remove bundled binary files.
	find . -name '*.jar' -exec rm -v {} + || die

	pushd external/lib > /dev/null || die

	find . -iname '*.zip' -exec rm -v {} + || die

	# Symlink the dependencies.
	java-pkg_jar-from jsr173{,.jar,_1.0_api_bundle.jar}
	java-pkg_jar-from jsr173{,.jar,_1.0_api.jar}

	mkdir xml-commons-resolver-1.1 || die
	java-pkg_jar-from xml-commons-resolver{,.jar} xcresolver.zip
	java-pkg_jar-from xml-commons-resolver{,.jar,-1.1/resolver.jar}

	# Put back the preserved old xbean jar.
	mv "${T}"/oldxbean.jar . || die

	popd > /dev/null || die

	# Create empty directories to let the build pass.
	mkdir -p build/classes/{jam,piccolo} || die

	echo '#!/bin/bash
cp="$(java-config -t):$(java-config -p piccolo,xmlbeans)"
java -Xmx256m -classpath "${cp}" org.apache.xmlbeans.impl.tool.SchemaCompiler "$@"' \
> "${S}/bin/scomp" || die "Failed to replace scomp"

}

JAVA_ANT_REWRITE_CLASSPATH="true"

EANT_BUILD_TARGET="deploy"
EANT_DOC_TARGET="docs"

EANT_EXTRA_ARGS="-Dpiccolo.classes.notRequired=true"
EANT_EXTRA_ARGS+=" -Djam.classes.notRequired=true"
EANT_EXTRA_ARGS+=" -Dsaxon9.jar.exists=true"

src_install() {
	java-pkg_dojar build/lib/xbean*.jar
	dobin bin/scomp

	dodoc NOTICE.txt README.txt
	if use doc; then
		java-pkg_dojavadoc build/docs/reference
		java-pkg_dohtml -r docs
	fi

	use source && java-pkg_dosrc src/*
}
