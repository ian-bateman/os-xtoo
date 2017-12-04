# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="A collection of Google's core Java libraries"
HOMEPAGE="https://code.google.com/p/guava-libraries/ https://github.com/google/guava"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/animal-sniffer-annotations:0
	dev-java/error-prone-annotations:0
	>=dev-java/j2objc-annotations-1.2:0
	dev-java/javax-inject:0
	dev-java/jsr305:0
"

S="${WORKDIR}/${P}/${PN}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVAC_ARGS="--add-exports jdk.unsupported/sun.misc=ALL-UNNAMED"
