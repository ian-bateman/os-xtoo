# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/arenn/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/raw/master/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java option processor 100% compatible with GNU C Library getopt"
HOMEPAGE="${BASE_URI}"
LICENSE="LGPL-2.1"
SLOT="0"

S="${WORKDIR}"

java_prepare() {
	mkdir -p src/main/java src/main/resources/gnu/getopt \
		|| die "Failed make dirs"
	mv gnu/getopt/*.java src/main/java \
		|| die "Failed to move *.java"
	mv gnu/getopt/*.properties src/main/resources/gnu/getopt \
		|| die "Failed to move *.properties"
}
