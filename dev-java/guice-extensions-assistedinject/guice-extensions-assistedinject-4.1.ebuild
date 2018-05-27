# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/guava:24
	dev-java/guice:${SLOT}
	dev-java/javax-inject:0
"
inherit java-pkg

DESCRIPTION="Guice extensions assisted inject"
HOMEPAGE="https://github.com/google/${MY_PN}/"
SRC_URI="https://github.com/google/${MY_PN}/archive/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_PN}-${PV}/extensions/assistedinject"

JAVA_SRC_DIR="src/"
