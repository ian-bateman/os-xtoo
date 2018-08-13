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
MY_MOD="biz.aQute.${PN##*-}"

BASE_URI="https://github.com/bndtools/bnd"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

OSGI_SLOT="7"

# Order matters, fails if libg is further down
CP_DEPEND="
	~dev-java/libg-${PV}:${SLOT}
	dev-java/aqute-jpm-clnt:0
	dev-java/aqute-services-services:0
	dev-java/aqute-services-struct:0
	~dev-java/bnd-annotation-${PV}:${SLOT}
	~dev-java/bndlib-${PV}:${SLOT}
	dev-java/osgi-annotation:0
	dev-java/osgi-compendium:${OSGI_SLOT}
	dev-java/osgi-core-api:${OSGI_SLOT}
	dev-java/osgi-impl-bundle-bindex:0
	dev-java/osgi-util:0
	dev-java/slf4j-api:0
	dev-java/xz-java:0
"

inherit java-pkg

DESCRIPTION="aQute Repository"
HOMEPAGE="https://www.aqute.biz/Bnd/Bnd"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"

java_prepare() {
	local f

	# add missing osgi 7 abstract methods...
	for f in Null Reporter; do
	sed -i -e '3iimport org.osgi.framework.Bundle;' \
		-e '14i \\t\tpublic <L extends org.osgi.service.log.Logger> L getLogger(Bundle bundle, String name, Class<L> loggerType) { return null; }' \
		-e '14i \\t\tpublic <L extends org.osgi.service.log.Logger> L getLogger(Class< ? > clazz, Class<L> loggerType) { return null; }' \
		-e '14i \\t\tpublic <L extends org.osgi.service.log.Logger> L getLogger(String name, Class<L> loggerType) { return null; }' \
		-e '14i \\t\tpublic org.osgi.service.log.Logger getLogger(Class< ? > clazz) { return null; }' \
		-e '14i \\t\tpublic org.osgi.service.log.Logger getLogger(String name) { return null; }' \
		src/aQute/bnd/deployer/repository/${f}LogService.java \
		|| die "Failed to sed/add missing abstract method"
	done
}
