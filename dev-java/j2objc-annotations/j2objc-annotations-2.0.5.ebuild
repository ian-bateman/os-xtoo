# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="${PN/-annotations/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Java to iOS Objective-C Annotations"
HOMEPAGE="https://j2objc.org/"
SRC_URI="https://github.com/google/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/${PN/${MY_PN}-/}"

JAVA_SRC_DIR="src/main/java/"
