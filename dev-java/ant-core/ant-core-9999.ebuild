# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-rel-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/commons-bsf:0
	dev-java/commons-bcel:0
	dev-java/commons-logging:0
	dev-java/commons-net:0
	dev-java/jakarta-oro:0
	dev-java/jakarta-regexp:0
	dev-java/javamail:0
	dev-java/javax-activation:0
	dev-java/jdepend:0
	dev-java/jsch:0
	dev-java/log4j:0
	dev-java/jai-core-bin:0
	dev-java/xalan:0
	dev-java/xml-commons-resolver:0
	dev-java/xz-java:0
"

inherit java-pkg

DESCRIPTION="Library and command-line tool to build Java applications"
HOMEPAGE="https://ant.apache.org/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/"

JAVA_RES_DIR="src/resources"

java_prepare() {
	# Copy defaultManifest.mf for inclusion in jar
	cp "${S}/src/main/org/apache/tools/ant/defaultManifest.mf" \
		"${S}/src/resources/org/apache/tools/ant/" \
		|| die "Failed to copy defaultManifest.mf"

	# Create version.txt for inclusion in jar
	echo -e "VERSION=${PV}\nDATE=$(date)" \
		> "${S}/src/resources/org/apache/tools/ant/version.txt" \
		|| die "Failed to create version.txt in resources"

	# Copy properties files for inclusion in jar
	local j
	for j in types listener taskdefs; do
		mkdir -p "${S}/src/resources/org/apache/tools/ant/${j}/" \
			|| die "Failed to create directory for resources"
		cp "${S}/src/main/org/apache/tools/ant/${j}/defaults.properties" \
			"${S}/src/resources/org/apache/tools/ant/${j}/" || die \
			"Failed to copy resource ${j}/defaults.properties"
	done

	# Copy xml files for inclusion in jar
	for j in / /types/conditions/; do
		cp "${S}src/main/org/apache/tools/ant${j}antlib.xml" \
			"${S}src/resources/org/apache/tools/ant${f}" \
			|| die "Failed to copy antlib.xml"
	done

	# Remove junit tasks
	rm -r "${S}/src/main/org/apache/tools/ant/taskdefs/optional/junit"* \
		|| die "Failed to remove taskdefs/optional/junit*"

	# Need to package NetRexx
	rm "${S}/src/main/org/apache/tools/ant/taskdefs/optional/NetRexxC.java" \
		|| die "Failed to remove taskdefs/optional/NetRexxC.java"

	# Move single file for ant-bootstrap.jar
	mkdir "${S}/bootstrap" || die "Could not make dir for main class"
	cp "${S}/src/main/org/apache/tools/ant/Main.java" "${S}/bootstrap/" \
		|| die "Could not copy Main.java for bootstrap.jar"
}

src_compile() {
	JAVA_JAR_FILENAME="ant-launcher.jar"
	JAVA_SRC_DIR="src/main/org/apache/tools/ant/launch/"
	java-pkg-simple_src_compile
	rm -r "${S}/src/main/org/apache/tools/ant/launch/" \
		|| "Failed to remove ant launcher classes"

	JAVA_CLASSPATH_EXTRA="${S}/ant-launcher.jar"
	JAVA_JAR_FILENAME="ant.jar"
	JAVA_SRC_DIR="src/main"
	JAVA_RES_DIR="src/resources"
	java-pkg-simple_src_compile

	JAVA_CLASSPATH_EXTRA+=":${S}/ant.jar"
	JAVA_JAR_FILENAME="ant-bootstrap.jar"
	JAVA_SRC_DIR="${S}/bootstrap/"
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dojar "${S}"*.jar

	dobin "${FILESDIR}/ant"

	dodir /usr/share/${PN}/bin
	local b
	for b in antRun antRun.pl runant.pl runant.py complete-ant-cmd.pl; do
		dobin "${S}/src/script/${b}"
		dosym ../../../../usr/bin/${b} /usr/share/${PN}/bin/${b}
	done
	dosym ../../../../usr/share/${PN}/bin /usr/share/ant/bin
	dosym ../../../../usr/share/${PN}/lib /usr/share/ant/lib

	insinto /usr/share/${PN}/etc
	doins "${S}/src/etc/"*.xsl
	doins -r "${S}/src/etc/"{checkstyle,performance}
	dosym ../../../../usr/share/${PN}/etc /usr/share/ant/etc

	echo "ANT_HOME=\"${EPREFIX}/usr/share/ant\"" > "${T}/20ant"
	doenvd "${T}/20ant"
}
