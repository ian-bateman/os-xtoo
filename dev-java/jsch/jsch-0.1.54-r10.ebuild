# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg

DESCRIPTION="JSch is a pure Java implementation of SSH2"
HOMEPAGE="https://www.jcraft.com/jsch/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"
KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"

CP_DEPEND="dev-java/jzlib:0"

DEPEND="${CP_DEPEND}
	app-arch/unzip
	>=virtual/jdk-9"

RDEPEND="
	${CP_DEPEND}
	>=virtual/jre-9"
