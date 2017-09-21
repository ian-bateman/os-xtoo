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

# Tests are currently broken. Appears to need older version of bcprov; but since bcprov is not slotted, this can cause conflicts.
# Needs further investigation; though, only a small part has tests and there are no tests for bcpg itself.
RESTRICT="test"

CP_DEPEND="~dev-java/bcprov-${PV}:${SLOT}"

DEPEND="${CDEPEND}
	app-arch/unzip
	test? (
		dev-java/ant-junit:0
	)
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}

java_prepare() {
	if ! use test; then
		local RM_TEST_FILES=(
			org/bouncycastle/openpgp/test
			org/bouncycastle/openpgp/examples/test
		)
		rm -rf "${RM_TEST_FILES[@]}" || die
	fi
}

src_test() {
	local cp="${PN}.jar:bcprov.jar:junit.jar"
	local pkg="org.bouncycastle"
	java -cp ${cp} ${pkg}.openpgp.test.AllTests | tee openpgp.tests
	grep -q FAILURES *.tests && die "Tests failed."
}

src_install() {
	java-pkg-simple_src_install
	use source && java-pkg_dosrc org
}
