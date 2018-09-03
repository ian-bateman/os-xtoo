# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit apache-module java-pkg-opt-2

MY_P="tomcat-connectors-${PV#-*}-src"

DESCRIPTION="Module for connecting Tomcat and Apache using the ajp13 protocol"
HOMEPAGE="https://tomcat.apache.org/connectors-doc/"
SRC_URI="mirror://apache/tomcat/tomcat-connectors/jk/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
IUSE="java"
SLOT="0"

S="${WORKDIR}/${MY_P}/native"

APACHE2_MOD_FILE="${S}/apache-2.0/${PN}.so"
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="JK"

CONF_DIR="${WORKDIR}/${MY_P}/conf"

DEPEND="java? ( >=virtual/jdk-9 )"
RDEPEND=""

need_apache

pkg_setup() {
	use java && java-pkg_pkg_setup
}

src_configure() {
	econf --with-apxs=${APXS} \
		--with-apr-config=/usr/bin/apr-config
}

src_compile() {
	emake LIBTOOL="/bin/sh $(pwd)/libtool --silent"
}

src_install() {
	insinto "${APACHE_CONFDIR}"
	newins "${CONF_DIR}/workers.properties" jk-workers.properties
	doins "${CONF_DIR}/uriworkermap.properties"

	apache-module_src_install
}
