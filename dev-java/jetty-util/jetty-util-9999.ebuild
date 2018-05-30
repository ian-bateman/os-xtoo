# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jetty"
MY_PV="${PV/.201/.v201}"
MY_PV="${MY_PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}.project"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}.project-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	dev-java/slf4j-api:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Jetty's Utils"
HOMEPAGE="https://www.eclipse.org/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_PN}.project-${MY_P}/${PN}/"

java_prepare() {
	sed -i -e "s|${SLOT}.z-SNAPSHOT|${PV}-os-xtoo|g" \
		src/main/java/org/eclipse/jetty/util/Jetty.java \
		|| die "Could not set version"
}
