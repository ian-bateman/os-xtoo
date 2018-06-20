# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PV="${PV//./_}"
MY_P="${PN^^}_${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit eutils java-pkg prefix systemd user

DESCRIPTION="Tomcat Servlet-4.0/JSP-2.3 Container"
HOMEPAGE="https://${PN}.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

IUSE="systemd extra-webapps"

ECJ_SLOT="4.7"
SAPI_SLOT="4.0"

DEPEND="app-admin/pwgen
	>=virtual/jdk-9:*
"

RDEPEND="
	dev-java/eclipse-ecj:${ECJ_SLOT}
	~dev-java/tomcat-annotations-api-${PV}:${SLOT}
	~dev-java/tomcat-api-${PV}:${SLOT}
	~dev-java/tomcat-bootstrap-${PV}:${SLOT}
	~dev-java/tomcat-catalina-${PV}:${SLOT}
	~dev-java/tomcat-catalina-ant-${PV}:${SLOT}
	~dev-java/tomcat-catalina-ha-${PV}:${SLOT}
	~dev-java/tomcat-catalina-storeconfig-${PV}:${SLOT}
	~dev-java/tomcat-catalina-tribes-${PV}:${SLOT}
	~dev-java/tomcat-coyote-${PV}:${SLOT}
	~dev-java/tomcat-dbcp-${PV}:${SLOT}
	~dev-java/tomcat-jasper-${PV}:${SLOT}
	~dev-java/tomcat-jasper-el-${PV}:${SLOT}
	~dev-java/tomcat-jaspic-api-${PV}:${SLOT}
	~dev-java/tomcat-jni-${PV}:${SLOT}
	~dev-java/tomcat-juli-${PV}:${SLOT}
	!<dev-java/tomcat-native-1.1.24
	~dev-java/tomcat-servlet-api-${PV}:${SAPI_SLOT}
	~dev-java/tomcat-util-${PV}:${SLOT}
	~dev-java/tomcat-util-scan-${PV}:${SLOT}
	~dev-java/tomcat-websocket-${PV}:${SLOT}
	~dev-java/tomcat-websocket-api-${PV}:${SLOT}
	>=virtual/jdk-9:*
	systemd? ( sys-apps/systemd )
"

S="${WORKDIR}/${MY_S}"

pkg_setup() {
	java-pkg_pkg_setup
	enewgroup tomcat 265
	enewuser tomcat 265 -1 /dev/null tomcat
}

java_prepare() {
	# For use of catalina.sh in netbeans
	sed -i -e "/^# ----- Execute The Requested Command/ a\
		CLASSPATH=\`jem --classpath ${PN}-${SLOT}\`" \
		bin/catalina.sh || die
}

src_compile() {
::
}

install_webapps() {
	insinto "${1}/webapps"
	doins -r webapps/{host-manager,manager,ROOT}
	use extra-webapps && doins -r webapps/{docs,examples}
}

src_install() {
	local dest jar JARS

	dest="/usr/share/${PN}-${SLOT}"
	exeinto "${dest}/bin"
	doexe bin/*.sh

	# link to jars installed by tomcat-* packages
	# bin
	JARS=( tomcat-bootstrap tomcat-juli )
	for jar in "${JARS[@]}"; do
		dosym "../../${jar}-${SLOT}/lib/${jar}.jar" \
			"${dest}/bin/${jar}.jar"
	done

	# lib
	JARS=( ant ha storeconfig tribes )
	JARS=( ${JARS[@]/#/catalina-} )
	JARS=(
		annotations-api api catalina ${JARS[@]} coyote dbcp jasper-el
		jasper jaspic-api jni util-scan util websocket websocket-api
	)
	JARS=( ${JARS[@]/#/${PN}-} )
	for jar in "${JARS[@]}"; do
		dosym "../../${jar}-${SLOT}/lib/${jar}.jar" \
			"${dest}/lib/${jar}.jar"
	done

	dosym "../../eclipse-ecj-${ECJ_SLOT}/lib/eclipse-ecj.jar" \
		"${dest}/lib/eclipse-ecj.jar"

	for jar in el-api jsp-api servlet-api; do
		dosym "../../tomcat-servlet-api-${SAPI_SLOT}/lib/${jar}.jar" \
			"${dest}/lib/${jar}.jar"
	done

	dodoc RELEASE-NOTES RUNNING.txt
	use doc && java-pkg_dojavadoc webapps/docs/api
	use source && java-pkg_dosrc java/*

	### Webapps ###

	# add missing docBase
	local a apps
	apps=(host-manager manager)
	for a in "${apps[@]}"; do
		sed -i -e "s|=\"true\" >|=\"true\" docBase=\"\${catalina.base}/webapps/${a}\" >|" \
			-e 's/\d+|/10\\.\\d+\\.\\d+\\.\\d+|192\\.\\d+\\.\\d+\\.\\d+|/g' \
			webapps/${a}/META-INF/context.xml \
			|| die "Failed to sed webapp docBase"
	done

	install_webapps "${dest}"

	### Config ###

	# replace the default pw with a random one, see #92281
	sed -i -e "s|SHUTDOWN|$(pwgen -s -B 15 1)|" conf/server.xml \
		|| die "Failed to replace default pw with random"

	insinto "${dest}"
	doins -r conf

	### rc ###

	cp "${FILESDIR}/${PN}"{.conf,.init,-server} "${T}" \
		|| die "Failed to copy conf/init files to temp"
	eprefixify "${T}/${PN}"{.conf,.init,-server}
	sed -i -e "s|@SLOT@|${SLOT}|g" "${T}/${PN}"{.conf,.init,-server} \
		|| die "Failed to sed/update slot in conf/init files"

	if use systemd; then
		cp "${FILESDIR}/${PN}"{-named.service,.service,-tmpfiles.d} \
			"${T}" || die "Failed to copy systemd files to temp"
		eprefixify "${T}/${PN}"{-named.service,.service,-tmpfiles.d}
		sed -i -e "s|@SLOT@|${SLOT}|g" "${T}/${PN}"{-named.service,.service,-tmpfiles.d} \
			|| die "Failed to sed/update slot in systemd files"

		systemd_newunit "${T}/${PN}.service" "${PN}-${SLOT}.service"
		systemd_newunit "${T}/${PN}-named.service" \
				"${PN}-${SLOT}@.service"
		systemd_newtmpfilesd "${T}/${PN}-tmpfiles.d" \
				"${PN}-${SLOT}.conf"
	fi

	sed -i -e "s|\${catalina.base}/logs|/var/log/${PN}/${PN}-${SLOT}|g" \
		conf/logging.properties || die "Failed to sed log path"

	insinto "/etc/${PN}-${SLOT}"
	doins -r conf/*

	exeinto "/usr/libexec/${PN}"
	newexe "${T}/${PN}-server" "server-${SLOT}"

	newconfd "${T}/${PN}.conf" "${PN}-${SLOT}"
	newinitd "${T}/${PN}.init" "${PN}-${SLOT}"

	dodir "/var/"{cache,lib,log,tmp}"/${PN}/${PN}-${SLOT}"

	dest="/var/lib/${PN}/${PN}-${SLOT}"
	install_webapps "${dest}"

	dosym "../../../../etc/${PN}-${SLOT}" "${dest}/conf"
	dosym "../../../../var/cache/${PN}/${PN}-${SLOT}" "${dest}/work"
	dosym "../../../../var/tmp/${PN}/${PN}-${SLOT}" "${dest}/temp"
	dosym "../../../../var/log/${PN}/${PN}-${SLOT}" "${dest}/logs"

	fowners ${PN}:${PN} -R "/var/"{cache,lib,log,tmp}"/${PN}/${PN}-${SLOT}"
}
