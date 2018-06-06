# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/jaxen:0
	dev-java/xerces:2
"

inherit java-pkg

DESCRIPTION="XML object model"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-modules=java.xml "

java_prepare() {
	rm -r src/nu/xom/{samples,tests} \
		src/nu/xom/tools/XHTMLJavaDoc.java \
		|| die "Failed to remove samples/tests and extra class"
}
