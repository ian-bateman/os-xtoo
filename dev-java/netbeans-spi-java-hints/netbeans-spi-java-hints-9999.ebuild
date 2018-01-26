# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-netbeans

CP_DEPEND="
	dev-java/byte-buddy-dep:0
	~dev-java/netbeans-api-annotations-common-${PV}:${SLOT}
	~dev-java/netbeans-api-java-classpath-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-${PV}:${SLOT}
	~dev-java/netbeans-api-progress-nb-${PV}:${SLOT}
	~dev-java/netbeans-code-analysis-${PV}:${SLOT}
	~dev-java/netbeans-editor-document-${PV}:${SLOT}
	~dev-java/netbeans-editor-lib-${PV}:${SLOT}
	~dev-java/netbeans-editor-mimelookup-${PV}:${SLOT}
	~dev-java/netbeans-editor-util-${PV}:${SLOT}
	~dev-java/netbeans-java-platform-${PV}:${SLOT}
	~dev-java/netbeans-java-source-${PV}:${SLOT}
	~dev-java/netbeans-java-source-base-${PV}:${SLOT}
	~dev-java/netbeans-lexer-${PV}:${SLOT}
	~dev-java/netbeans-lib-nbjavac-${PV}:${SLOT}
	~dev-java/netbeans-openide-awt-${PV}:${SLOT}
	~dev-java/netbeans-openide-dialogs-${PV}:${SLOT}
	~dev-java/netbeans-openide-filesystems-${PV}:${SLOT}
	~dev-java/netbeans-openide-loaders-${PV}:${SLOT}
	~dev-java/netbeans-openide-modules-${PV}:${SLOT}
	~dev-java/netbeans-openide-nodes-${PV}:${SLOT}
	~dev-java/netbeans-openide-text-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-lookup-${PV}:${SLOT}
	~dev-java/netbeans-openide-util-ui-${PV}:${SLOT}
	~dev-java/netbeans-options-api-${PV}:${SLOT}
	~dev-java/netbeans-parsing-api-${PV}:${SLOT}
	~dev-java/netbeans-projectapi-${PV}:${SLOT}
	~dev-java/netbeans-queries-${PV}:${SLOT}
	~dev-java/netbeans-refactoring-api-${PV}:${SLOT}
	~dev-java/netbeans-spi-editor-hints-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports=jdk.javadoc/com.sun.tools.javadoc.main=ALL-UNNAMED "
