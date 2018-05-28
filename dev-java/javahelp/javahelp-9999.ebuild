# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/.05.0/_05}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/javaee/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="java-virtuals/servlet-api:4.0"

inherit java-pkg

DESCRIPTION="${PN} API Reference Implementation"
HOMEPAGE="https://javaee.github.io/${PN}/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_P}/jhMaster/"

JAVA_SRC_DIR="
	JavaHelp/src
	JSearch/client
	JSearch/indexer
"

JAVAC_ARGS+=" --add-exports=java.desktop/java.awt.dnd.peer=ALL-UNNAMED "

java_prepare() {
	# Requires legacy jdic, abandoned -> https://github.com/gelosie/jdic
	rm "JavaHelp/src/new/javax/help/plaf/basic/BasicNativeContentViewerUI.java" \
		|| die "Could not remove class importing legacy files"
}
