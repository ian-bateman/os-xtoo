# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/rzwitserloot/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Very spicy additions to the Java programming language."
HOMEPAGE="https://projectlombok.org/"
LICENSE="Apache-2.0"
SLOT="0"

ECLIPSE_SLOT="4.7"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/cmdreader:0
	dev-java/eclipse-jdt-core:${ECLIPSE_SLOT}
	dev-java/eclipse-jdt-ui:${ECLIPSE_SLOT}
	dev-java/eclipse-jface-text:${ECLIPSE_SLOT}
	dev-java/eclipse-core-jobs:${ECLIPSE_SLOT}
	dev-java/eclipse-core-resources:${ECLIPSE_SLOT}
	dev-java/eclipse-core-runtime:${ECLIPSE_SLOT}
	dev-java/eclipse-equinox-common:${ECLIPSE_SLOT}
	dev-java/freemarker:0
	dev-java/java2html:0
	dev-java/lombok-patcher:0
	dev-java/markdownj:0
	dev-java/osgi-core-api:6
	dev-java/spi:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

PATCHES=( "${FILESDIR}/javac-type.patch" )

JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.file.PathFileObject=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.jvm=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util.swing=ALL-UNNAMED "

java_prepare() {
	mv src/stubs/org src || die "Failed to move needed stub"
	rm -r src/{javac-only-stubs,stubs,stubsstubs,testAP,useTestAP} \
		src/core/lombok/javac/apt/Javac{6,7}BaseFileObjectWrapper.java \
		src/core/lombok/javac/Javac{6,8}BasedLombokOptions.java \
		src/utils/lombok/javac/java{6,7} \
		|| die "Failed to remove sources not to be included"

	cp "${FILESDIR}/PackageName.java" src/utils/lombok/javac/ \
		|| die "Failed to replaced utils/lombok/javac/PackageName.java"

	sed -i -e '113i\\t@Override' \
		-e '113i\\t\tcom.sun.tools.javac.file.PathFileObject getSibling(String basename) { throw new Exception("Not implemented"); }' \
		src/core/lombok/javac/apt/Javac9BaseFileObjectWrapper.java \
		|| die "Failed to sed/fix java 9 missing override"

	sed -i -e '50,83d;114,119d;121,148d' \
		src/core/lombok/javac/apt/LombokFileObjects.java \
		|| die "Failed to sed/remove < java 9 support"

	sed -i -e '512d;536,550d;' src/core/lombok/javac/JavacAST.java \
		|| die "Failed to sed/remove < java 9 support"

	sed -i -e '540,542d;544d;547d;568d;570d;574,576d;580d' \
		src/delombok/lombok/delombok/Delombok.java \
		|| die "Failed to sed/remove < java 9 support"

	sed -i -e '25,26d;35,46d;61,65d;67d' \
		src/delombok/lombok/delombok/LombokOptionsFactory.java \
		|| die "Failed to sed/remove < java 9 support"

}
