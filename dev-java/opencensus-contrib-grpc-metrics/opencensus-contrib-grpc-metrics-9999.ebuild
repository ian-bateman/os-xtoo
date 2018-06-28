# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-java"
MY_P="${MY_PN}-${PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD/-//}"
MY_MOD="${MY_MOD/-/_}"
BASE_URI="https://github.com/census-instrumentation/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/guava:25
	~dev-java/opencensus-api-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="A stats collection and distributed tracing framework - ${PN#*-}"
HOMEPAGE="https://opencensus.io"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
