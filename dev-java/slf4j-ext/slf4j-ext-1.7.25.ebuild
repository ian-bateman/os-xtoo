# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Simple Logging Facade for Java"
HOMEPAGE="https://www.slf4j.org/"
SRC_URI="https://www.slf4j.org/dist/${P/-ext/}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/cal10n:0
	dev-java/commons-lang:2
	dev-java/javassist:3
	~dev-java/slf4j-api-${PV}:0"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

S="${WORKDIR}/${P/-ext/}/${PN}"

RESTRICT="test" # causes loop with log4j:2

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit-4"
EANT_TEST_ANT_TASKS="ant-junit"

java_prepare() {
	cp -v "${FILESDIR}"/${PN}-${SLOT}-build.xml build.xml || die
}

src_install() {
	java-pkg_dojar "${S}"/target/${PN}.jar
	use doc && java-pkg_dojavadoc "${S}"/target/site/apidocs
	use source && java-pkg_dosrc "${S}"/src/main/java/org
}
