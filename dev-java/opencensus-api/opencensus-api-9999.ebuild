# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}-java"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/census-instrumentation/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/auto-value:0
	dev-java/escapevelocity:0
	dev-java/error-prone-annotations:0
	dev-java/grpc-context:0
	dev-java/guava:25
	dev-java/jsr305:0
"

inherit java-pkg

DESCRIPTION="A stats collection and distributed tracing framework - ${PN#*-}"
HOMEPAGE="https://opencensus.io"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"
