# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/jruby/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg

DESCRIPTION="Simple Directed Graph Implementation"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="0"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/"
