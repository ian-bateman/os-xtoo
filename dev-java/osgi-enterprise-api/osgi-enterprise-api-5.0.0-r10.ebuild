# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/eclipse-javax-persistence:2
	dev-java/osgi-annotation:0
	dev-java/osgi-core-api:${SLOT}
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="OSGi Service Platform Enterprise API (Companion Code)"
HOMEPAGE="https://www.osgi.org/Specifications/HomePage"
SRC_URI="https://www.osgi.org/download/r${PV%%.*}/osgi.enterprise-${PV}.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"

DEPEND+=" app-arch/unzip:0"

JAVA_SRC_DIR="OSGI-OPT/src"
JAVA_RM_FILES=( org )
