# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/javax-inject:0
	dev-java/jax-rs:2
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-server-${PV}:${SLOT}
	~dev-java/jersey-security-oauth1-signature-${PV}:${SLOT}
	dev-java/javax-annotation:0
"

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Security OAuth1 Server"
HOMEPAGE="https://jersey.github.io/"
LICENSE="CDDL GPL-2-with-linking-exception"

S="${WORKDIR}/${MY_P}/security/${PN#*-*-}"
