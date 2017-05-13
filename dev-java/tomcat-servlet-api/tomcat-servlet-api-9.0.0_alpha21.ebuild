# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="source"

inherit eutils java-pkg-2 java-ant-2

MY_PV="${PV/_alpha/.M}"
MY_A="apache-${PN}-${MY_PV}-src"
MY_P="${MY_A/-servlet-api/}"

DESCRIPTION="Tomcat's Servlet API 4.0/JSP API 2.4?/EL API 3.1? implementation"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="mirror://apache/tomcat/tomcat-9/v${MY_PV}/src/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="4.0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/"

java_prepare() {
	rm -fR */*/build.xml
	cp "${FILESDIR}/${SLOT}-build.xml" build.xml \
		|| die "Could not replace build.xml"
}

src_install() {
	java-pkg_dojar "${S}"/output/build/lib/*.jar
	use source && java-pkg_dosrc java/javax/servlet/
}
