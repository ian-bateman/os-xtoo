# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 prefix systemd user

MY_PV="${PV/_alpha/.M}"
MY_P="apache-${PN}-${MY_PV}-src"

DESCRIPTION="Tomcat Servlet-4.0/JSP-2.3 Container"
HOMEPAGE="https://${PN}.apache.org/"
SLOT="${PV%%.*}"
SRC_URI="mirror://apache/${PN}/${PN}-${SLOT}/v${MY_PV}/src/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~amd64-linux"
IUSE="systemd extra-webapps"
LICENSE="Apache-2.0"

ECJ_SLOT="4.7"
SAPI_SLOT="4.0"

CDEPEND="
	~dev-java/tomcat-server-${PV}:${SLOT}
	~dev-java/tomcat-servlet-api-${PV}:${SAPI_SLOT}
"
DEPEND="${CDEPEND}
	app-admin/pwgen
	>=virtual/jdk-1.8:*
"
RDEPEND="${CDEPEND}
	dev-java/eclipse-ecj:${ECJ_SLOT}
	!<dev-java/tomcat-native-1.1.24
	>=virtual/jdk-1.8:*
	systemd? ( sys-apps/systemd )
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	java-pkg-2_pkg_setup
	enewgroup tomcat 265
	enewuser tomcat 265 -1 /dev/null tomcat
}

java_prepare() {
	# For use of catalina.sh in netbeans
	sed -i -e "/^# ----- Execute The Requested Command/ a\
		CLASSPATH=\`java-config --classpath ${PN}-${SLOT}\`" \
		bin/catalina.sh || die
}

# Needed to create classpath in package.env
EANT_GENTOO_CLASSPATH="tomcat-server-${SLOT}"

src_compile() {
	local donothing;
}

install_webapps() {
	insinto "${1}/webapps"
	doins -r webapps/{host-manager,manager,ROOT}
	use extra-webapps && doins -r webapps/{docs,examples}
}

src_install() {
	local dest="/usr/share/${PN}-${SLOT}"

	dodir "${dest}/bin"
	# link to jars installed by tomcat-server
	local jar JARS
	JARS=(bootstrap tomcat-juli)
	for jar in ${JARS[@]}; do
		dosym "../../${PN}-server-${SLOT}/lib/${jar}.jar" \
			"${dest}/bin/${jar}.jar"
	done

	exeinto "${dest}/bin"
	doexe bin/*.sh

	JARS=(annotations-api catalina-ant catalina-ha
		catalina-storeconfig catalina-tribes catalina
		jasper-el jasper jaspic-api tomcat-api tomcat-coyote
		tomcat-dbcp tomcat-i18n-es tomcat-i18n-fr
		tomcat-i18n-ja tomcat-jni tomcat-util-scan tomcat-util
		tomcat-websocket websocket-api
	)
	for jar in ${JARS[@]}; do
		dosym "../../${PN}-server-${SLOT}/lib/${jar}.jar" \
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
	for a in ${apps[@]}; do
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

	# prepend gentoo.classpath to common.loader, see #453212
	sed -i -e 's/^common\.loader=/\0${gentoo.classpath},/' \
		conf/catalina.properties || die "Failed to sed classpath"

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
