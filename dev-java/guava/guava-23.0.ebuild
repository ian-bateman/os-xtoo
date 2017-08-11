# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A collection of Google's core Java libraries"
HOMEPAGE="https://code.google.com/p/guava-libraries/ https://github.com/google/guava"
SRC_URI="https://github.com/google/guava/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="$(get_major_version)"
KEYWORDS="~amd64"

CP_DEPEND="
	dev-java/animal-sniffer-annotations:0
	dev-java/error-prone-annotations:0
	>=dev-java/j2objc-annotations-1.2:0
	dev-java/javax-inject:0
	dev-java/jsr305:0
	java-virtuals/jdk-with-com-sun:0
"

S="${WORKDIR}/${P}/${PN}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"
