# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="bnd"
MY_PV="${PV}"
case ${PV} in
	*_pre) MY_PV="${MY_PV/_pre/.DEV}" ;;
	*_rc) MY_PV="${MY_PV/_rc/.RC}" ;;
	*) MY_PV+=".REL";;
esac
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="biz.aQute.${PN}"
BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

OSGI_SLOT="7"

# Do not change order, osgi-ds MUST come before others
CP_DEPEND="
	~dev-java/bnd-annotation-${PV}:${SLOT}
	~dev-java/libg-${PV}:${SLOT}
	dev-java/osgi-annotation:0
	dev-java/osgi-ds:0
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-util:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="A swiss army knife for OSGi"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

JAVA_RM_FILES=( src/aQute/bnd/junit/ )

#java_prepare() {
	# add missing osgi 7 abstract methods...
#	sed -i -e '17iimport org.osgi.service.log.Logger;' \
#		-e '77i \\t\tpublic StackTraceElement getLocation() { return exception.getStackTrace()[0]; }' \
#		-e '77i \\t\tpublic  org.osgi.service.log.LogLevel getLogLevel() { return null; }' \
#		-e '77i \\t\tpublic String getLoggerName() { return new String(); }' \
#		-e '77i \\t\tpublic String getThreadInfo() { return new String(); }' \
#		-e '77i \\t\tpublic long getSequence() { return 0l; }' \
#		-e '113i \\t\tpublic <L extends Logger> L getLogger(Bundle bundle, String name, Class<L> loggerType) { return null; }' \
#		-e '113i \\t\tpublic <L extends Logger> L getLogger(Class< ? > clazz, Class<L> loggerType) { return null; }' \
#		-e '113i \\t\tpublic <L extends Logger> L getLogger(String name, Class<L> loggerType) { return null; }' \
#		-e '113i \\t\tpublic Logger getLogger(Class< ? > clazz) { return null; }' \
#		-e '113i \\t\tpublic Logger getLogger(String name) { return null; }' \
#		src/aQute/bnd/junit/ConsoleLogger.java \
#		|| die "Failed to sed/add missing abstract method"
#}
