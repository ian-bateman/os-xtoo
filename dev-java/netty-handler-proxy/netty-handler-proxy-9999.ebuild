# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	~dev-java/netty-buffer-${PV}:${SLOT}
	~dev-java/netty-common-${PV}:${SLOT}
	~dev-java/netty-codec-${PV}:${SLOT}
	~dev-java/netty-codec-http-${PV}:${SLOT}
	~dev-java/netty-codec-socks-${PV}:${SLOT}
	~dev-java/netty-transport-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Netty ${MY_MOD}"
HOMEPAGE="https://${MY_PN}.io/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${MY_MOD}"
