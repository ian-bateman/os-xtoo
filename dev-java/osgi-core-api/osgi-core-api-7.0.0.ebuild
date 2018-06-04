# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="dev-java/osgi-annotation:0"

SLOT="${PV%%.*}"

inherit java-pkg

DESCRIPTION="OSGi Service Platform Core API (Companion Code)"
HOMEPAGE="https://www.osgi.org/Specifications/HomePage"
SRC_URI="https://www.osgi.org/download/r${SLOT}/osgi.core-${PV}.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

DEPEND+=" app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"
