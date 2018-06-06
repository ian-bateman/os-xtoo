# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/${PN/x/x-}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/cglib:3
	dev-java/dom4j:2
	dev-java/javax-activation:0
	dev-java/jdom:0
	dev-java/jdom:2
	dev-java/jettison:0
	dev-java/joda-time:0
	dev-java/kxml:0
	dev-java/xmlpull:0
	dev-java/xom:0
	dev-java/xpp:3
"

inherit java-pkg

DESCRIPTION="Serialize Java objects to XML and back again."
HOMEPAGE="https://x-stream.github.io/"
LICENSE="BSD-3-clause"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

# From tree, only part copied
# Two drivers for two very old implementations of StAX.
# StAX has been last-rited from Gentoo as it is now part of the Java 6 JDK.
# See bug 561504. These drivers rely on ancient APIs that aren't maintained
# upstream and may contain security holes.
JAVA_RM_FILES=(
	src/java/com/thoughtworks/xstream/io/xml/WstxDriver.java
	src/java/com/thoughtworks/xstream/io/xml/BEAStaxDriver.java
)
