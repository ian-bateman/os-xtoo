# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="google-oauth-java-client"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:6}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

JETTY_SLOT="9.4"

CP_DEPEND="
	~dev-java/google-http-client-${PV}:${SLOT}
	~dev-java/google-oauth-client-java6-${PV}:${SLOT}
	dev-java/jetty-server:${JETTY_SLOT}
	dev-java/jetty-util:${JETTY_SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Google OAuth Client Library for Java ${PN:20}"
HOMEPAGE="https://developers.google.com/api-client-library/java/${PN}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/${PN}"

java_prepare() {
	sed -i -e '118,119d;' \
		src/main/java/com/google/api/client/extensions/jetty/auth/oauth2/LocalServerReceiver.java \
		|| "Failed to upgrade Jetty"
	sed -i -e 's|mortbay.jetty|eclipse.jetty.server|g' \
		-e '28iimport org.eclipse.jetty.server.ServerConnector;' \
		-e '118i\ \ \ \ server = new Server();' \
		-e '118i\ \ \ \ ServerConnector connector = new ServerConnector(server);' \
		-e '118i\ \ \ \ connector.setPort(port != -1 ? port : 0);' \
		-e '118i\ \ \ \ server.setConnectors(new Connector[] { connector });' \
		-e 's|addHandler|setHandler|' \
		-e 's|HttpServletRequest request.*|Request r,HttpServletRequest request, HttpServletResponse response)|' \
		src/main/java/com/google/api/client/extensions/jetty/auth/oauth2/LocalServerReceiver.java \
		|| "Failed to upgrade Jetty"
}
