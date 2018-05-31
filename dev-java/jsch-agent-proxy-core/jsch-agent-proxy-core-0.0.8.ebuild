# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:16}"
MY_P="${MY_PN}-${PV}"

inherit java-pkg

DESCRIPTION="A proxy to ssh-agent and Pageant in Java"
HOMEPAGE="https://github.com/ymnk/${MY_PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="BSD-3-clause"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${MY_PN}-${PV}/${PN}"
