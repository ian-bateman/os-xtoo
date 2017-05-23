# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-jdk15on-${PV/./}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="https://www.bouncycastle.org/java.html"
SRC_URI="https://www.bouncycastle.org/download/${MY_P}.tar.gz"
LICENSE="BSD"
KEYWORDS="~amd64"
SLOT="$(get_version_component_range 1-2)"

CP_DEPEND="
	dev-java/bcprov:${SLOT}
	dev-java/bcpkix:${SLOT}
	dev-java/junit:0
	java-virtuals/jaf:0
	dev-java/oracle-javamail:0
"

DEPEND="${CP_DEPEND}
	app-arch/unzip
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}"

# Package can't be built with test as bcprov and bcpkix can't be built with test.
RESTRICT="test"

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}

java_prepare() {
	JAVA_RM_FILES=(
		org/bouncycastle/mail/smime/test/*
		org/bouncycastle/mail/smime/examples/CreateSignedMail.java
	)
}

src_install() {
	java-pkg-simple_src_install
	use source && java-pkg_dosrc org
}
