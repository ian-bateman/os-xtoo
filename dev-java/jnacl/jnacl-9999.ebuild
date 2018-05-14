# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/trevorbernard/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="NaCl curve25519xsalsa20poly1305 crypto algorithm and related primitives"
HOMEPAGE="https://neilalexander.eu/jnacl"
LICENSE="BSD-2-clause"
SLOT="0"

S="${WORKDIR}/${P}"
