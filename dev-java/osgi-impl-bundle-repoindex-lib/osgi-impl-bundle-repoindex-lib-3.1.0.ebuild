# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Bundle Repository Indexer lib"
HOMEPAGE="http://www.aqute.biz/Bnd/Bnd"
SRC_URI="https://github.com/bndtools/bnd/archive/${PV}.REL.tar.gz -> bnd-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/osgi-compendium:4
	dev-java/osgi-core-api:4
	dev-java/osgi-impl-bundle-repoindex-api:${SLOT}"

DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"

S="${WORKDIR}/bnd-${PV}.REL/org.${PN//-/.}"

JAVA_GENTOO_CLASSPATH="
	osgi-compendium-4
	osgi-core-api-4
	osgi-impl-bundle-repoindex-api-${SLOT}
"
JAVA_SRC_DIR="src/"

java_prepare() {
	java-pkg_clean

#	if ! use test ; then
		rm -rf test* || die "Failed to remove tests."
#	fi
}

