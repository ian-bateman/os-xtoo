# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

DEPEND=">=virtual/jdk-9"
#	~nb-ide/netbeans-html-validation-${PV}:${SLOT}
#	~nb-ide/netbeans-image-${PV}:${SLOT}
#	~nb-ide/netbeans-languages-diff-${PV}:${SLOT}
#	~nb-ide/netbeans-languages-manifest-${PV}:${SLOT}
#	~nb-ide/netbeans-languages-yaml-${PV}:${SLOT}
RDEPEND="
	~nb-ide/netbeans-css-visual-${PV}:${SLOT}
	~nb-ide/netbeans-editor-actions-${PV}:${SLOT}
	~nb-ide/netbeans-editor-bracesmatching-${PV}:${SLOT}
	~nb-ide/netbeans-editor-search-${PV}:${SLOT}
	~nb-ide/netbeans-html-${PV}:${SLOT}
	~nb-ide/netbeans-html-parser-${PV}:${SLOT}
	~nb-ide/netbeans-parsing-api-${PV}:${SLOT}
	~nb-ide/netbeans-properties-${PV}:${SLOT}
	~nb-ide/netbeans-xml-core-${PV}:${SLOT}
	~nb-ide/netbeans-xml-schema-completion-${PV}:${SLOT}
	~nb-ide/netbeans-xml-text-${PV}:${SLOT}
	~nb-ide/netbeans-xml-tools-${PV}:${SLOT}
	~nb-ide/netbeans-xsl-${PV}:${SLOT}
	~nb-ide/netbeans-spi-editor-hints-${PV}:${SLOT}
	>=virtual/jre-9
"

JAVA_NO_SRC=0
