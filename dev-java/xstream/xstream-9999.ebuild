# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/${PN/x/x-}/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Serialize Java objects to XML and back again."
HOMEPAGE="https://x-stream.github.io/"
LICENSE="BSD-3-clause"
SLOT="0"

CP_DEPEND="
	dev-java/cglib:3
	dev-java/dom4j:1
	dev-java/jdom:0
	dev-java/jdom:2
	dev-java/jettison:0
	dev-java/joda-time:0
	dev-java/kxml:2
	dev-java/xmlpull:0
	dev-java/xom:0
	dev-java/xpp3:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS="--add-modules java.activation "
JAVAC_ARGS+="--add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

# From tree, only part copied
# Two drivers for two very old implementations of StAX.
# StAX has been last-rited from Gentoo as it is now part of the Java 6 JDK.
# See bug 561504. These drivers rely on ancient APIs that aren't maintained
# upstream and may contain security holes.
JAVA_RM_FILES=(
	src/java/com/thoughtworks/xstream/io/xml/WstxDriver.java
	src/java/com/thoughtworks/xstream/io/xml/BEAStaxDriver.java
)
