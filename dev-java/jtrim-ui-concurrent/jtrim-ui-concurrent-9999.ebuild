# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JTrim"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/kelemen/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/jtrim-access-${PV}:${SLOT}
	~dev-java/jtrim-concurrent-${PV}:${SLOT}
	~dev-java/jtrim-executor-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Asynchronous Computation in UIs"
HOMEPAGE="${BASE_URI}/subprojects/${PN}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN}"
