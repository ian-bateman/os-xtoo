# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/releases/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-releases-${PV}"
fi

GUICE_SLOT="4"

CP_DEPEND="
	dev-java/cdi-api:0
	dev-java/guice:${GUICE_SLOT}
	dev-java/guice-servlet:${GUICE_SLOT}
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	dev-java/osgi-core-api:7
	dev-java/slf4j-api:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Modular JSR330-based container"
HOMEPAGE="https://www.eclipse.org/sisu/"
LICENSE="EPL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/org.eclipse.${MY_PN}"

java_prepare() {
	find "${S}" -name '*Test*.java' -type f -delete \
		|| die "Failed to remove tests"
}
