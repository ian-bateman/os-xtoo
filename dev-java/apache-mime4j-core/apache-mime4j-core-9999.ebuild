# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="james-mime4j"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PN%*-*}-project-${PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${PN%*-*}-project-${PV}"
fi

inherit java-pkg

DESCRIPTION="Parser for e-mail message streams in plain rfc822 and MIME format"
HOMEPAGE="https://james.apache.org/mime4j/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN##*-}"
