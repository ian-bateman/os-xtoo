# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/animal-sniffer-annotations:0
	dev-java/checker-compatqual:0
	dev-java/checker-qual:0
	dev-java/error-prone-annotations:0
	>=dev-java/j2objc-annotations-1.2:0
	dev-java/javax-inject:0
	dev-java/jsr305:0
"

inherit java-pkg

DESCRIPTION="A collection of Google's core Java libraries"
HOMEPAGE="https://code.google.com/p/guava-libraries/ https://github.com/google/guava"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${P}/${PN}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
