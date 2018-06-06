# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/guava:24
	dev-java/guice:4
	dev-java/javax-inject:0
"

inherit java-pkg

DESCRIPTION="Rocoto is a small collection of reusable Modules for Google Guice"
SRC_URI="https://github.com/99soft/${PN}/archive/${P}.tar.gz"
HOMEPAGE="https://99soft.github.io/rocoto/"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${PN}-${P}"
