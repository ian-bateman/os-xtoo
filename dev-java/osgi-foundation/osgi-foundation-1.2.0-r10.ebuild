# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Seems to be package of Java ME? javax.microedition + others"
HOMEPAGE="http://felix.apache.org/"
SRC_URI="https://dev.gentoo.org/~tomwij/files/dist/${P}.tar.xz"

LICENSE="Apache-2.0 OSGi-Specification-2.0"
KEYWORDS="~amd64"
SLOT="0"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"
