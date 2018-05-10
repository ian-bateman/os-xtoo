# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="OSGi Utlities"
HOMEPAGE="https://www.osgi.org/developer/specifications/"
SRC_URI="https://osgi.org/download/r6/osgi.cmpn-6.0.0.jar"
# This package is found within sources for another see SRC_URI

LICENSE="Apache-2.0 OSGi-Specification-2.0"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/osgi-annotation:0
	dev-java/osgi-core-api:6"

DEPEND="app-arch/unzip:0
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

JAVA_SRC_DIR="OSGI-OPT/src/"

java_prepare() {
	# Removing classes vs limiting sources, to get clean bundle/packageinfo
	rm -fR ${JAVA_SRC_DIR}/org/osgi/{application,namespace,service}
}
