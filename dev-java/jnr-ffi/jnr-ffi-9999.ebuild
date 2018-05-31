# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN:0:3}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/asm:6
	dev-java/jffi:0
	dev-java/jnr-x86asm:0
"

inherit java-pkg

DESCRIPTION="An abstracted interface to invoking native functions from java"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-3 )"

S="${WORKDIR}/${MY_S}"
