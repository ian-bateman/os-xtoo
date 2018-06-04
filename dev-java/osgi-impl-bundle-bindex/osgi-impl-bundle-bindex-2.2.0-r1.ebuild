# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.${PN//-/.}"

BASE_URI="https://github.com/bndtools/bundle-hub/"

SLOT="0"

BND_SLOT="4"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/bnd-annotation:${BND_SLOT}
	dev-java/bndlib:${BND_SLOT}
	dev-java/kxml:0
	dev-java/osgi-core-api:5
	dev-java/osgi-service-obr:0
	dev-java/xmlpull:0
"

inherit java-pkg

DESCRIPTION="OSGi Bundle Bindex"
HOMEPAGE="${BASE_URI}tree/master/org.osgi.impl.bundle.bindex"
SRC_URI="${BASE_URI}raw/master/${MY_PN}/${MY_PN}-${PV}.jar -> ${P}.jar"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/"

JAVA_SRC_DIR="OSGI-OPT/src/"
