# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}3"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/jaxb-api:0
	dev-java/jcache:0
	dev-java/offheap-store:0
	dev-java/sizeof:0
	dev-java/slf4j-api:0
	dev-java/spotbugs-annotations:0
	dev-java/statistics:2
"

inherit java-pkg

DESCRIPTION="Open source, standards-based cache"
HOMEPAGE="https://www.${PN}.org"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/jaxb-xjc:0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="
	107/src/main/java
	api/src/main/java
	core/src/main/java
	impl/src/main/java
	xml/src/main/java
"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "

java_prepare() {
	local f

	# Alternative to xjc is scomp from beanutils
	xjc -d xml/src/main/java -p org.ehcache.xml.model \
		xml/src/main/resources/ehcache-core.xsd \
		|| die "Failed to generate java source files via xjc"

	for f in $(grep -l -m1 jsr166e\\.LongAdder -r * ); do
		sed -i -e "s|org.terracotta.statistics.jsr166e|java.util.concurrent.atomic|" \
			${f} || die "Failed to change import"
	done
}
