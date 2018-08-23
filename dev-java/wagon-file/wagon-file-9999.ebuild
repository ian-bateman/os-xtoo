# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/maven-${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="maven-${MY_PN}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/wagon-provider-api-${PV}:${SLOT}
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Wagon provider gets and puts artifacts using file system protocol"
HOMEPAGE="https://maven.apache.org/wagon/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_PN}-providers/${PN}"
