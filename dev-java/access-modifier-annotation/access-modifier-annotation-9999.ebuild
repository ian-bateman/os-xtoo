# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:15}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/kohsuke/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}/${PN}"
fi

CP_DEPEND="
	dev-java/annotation-indexer:0
	dev-java/asm:6
"

inherit java-pkg

DESCRIPTION="Enforce access restrictions to deprecated code"
HOMEPAGE="${BASE_URI}"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}"
