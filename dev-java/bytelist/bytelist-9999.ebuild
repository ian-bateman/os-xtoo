# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jruby/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="dev-java/jcodings:1"

inherit java-pkg

DESCRIPTION="org.jruby.util.ByteList byte container"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/"
