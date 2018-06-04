# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="OSGi Service Platform Core API (Companion Code)"
HOMEPAGE="https://www.osgi.org/Specifications/HomePage"
SRC_URI="https://www.osgi.org/download/r${PV%%.*}v43/osgi.core-${PV}.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="${PV%%.*}"

DEPEND+=" app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"
JAVA_RM_FILES=( org )
