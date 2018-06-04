# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="mongo-java-driver"
MY_P="${MY_PN}-r${PV}"

BASE_URI="https://github.com/${PN##*-}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/r${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV%%.*}"

NETTY_SLOT="4.1"

CP_DEPEND="
	~dev-java/bson-${PV}:${SLOT}
	dev-java/netty-common:${NETTY_SLOT}
	dev-java/netty-transport:${NETTY_SLOT}
	~dev-java/mongodb-driver-core-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="MongoDB Java Driver Async"
HOMEPAGE="https://mongodb.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN#*-}"
