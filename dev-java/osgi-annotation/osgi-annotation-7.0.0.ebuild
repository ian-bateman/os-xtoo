# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

DEPEND="app-arch/unzip:0"

inherit java-pkg

DESCRIPTION="OSGi Core Annotation Code"
HOMEPAGE="https://www.osgi.org/Specifications/HomePage"
SRC_URI="https://www.osgi.org/download/r${PV%%.*}/${PN/-/.}-${PV}.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

JAVA_SRC_DIR="OSGI-OPT/src"
