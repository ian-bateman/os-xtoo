# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="https://www.slf4j.org/"
SRC_URI="https://www.slf4j.org/dist/${P/-nop/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="~dev-java/slf4j-api-${PV}:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
	test? (
		dev-java/ant-junit:0
		dev-java/junit:4
	)"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P/-nop/}/${PN}"

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_TEST_GENTOO_CLASSPATH="slf4j-api,junit-4"
EANT_TEST_ANT_TASKS="ant-junit"

java_prepare() {
	cp "${FILESDIR}"/${PN}-${SLOT}-build.xml build.xml || die
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
}

src_test() {
	java-pkg-2_src_test
}
