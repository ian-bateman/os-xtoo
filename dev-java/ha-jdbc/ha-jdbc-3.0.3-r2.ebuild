# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="High-Availability JDBC"
HOMEPAGE="https://${PN}.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

CP_DEPEND="
	dev-java/berkeley-db-je:0
	dev-java/commons-codec:0
	dev-java/commons-logging:0
	dev-java/commons-pool:0
	dev-java/jaxb-api:0
	dev-java/jboss-logging:0
	dev-java/jgroups:3
	dev-java/slf4j-api:0
	dev-java/sqljet:0
"

# Project uses Berkeley DB Java Edition from Oracle
# pure java version of Berkeley DB
# tried to use open source one but has issues and likely using the pure
# java one for a reason
#	sys-libs/db:6.0[java]

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}/"

java_prepare() {
	sed -i -e "s|\${project.version}|${PV}|" \
		src/main/java/net/sf/hajdbc/Version.properties \
		|| die "Could not set version"

	cp src/site/resources/xsd/ha-jdbc-2.0.xsd src/main/resources/ \
		|| die "Could not copy ${PN}-*.xsd to resources"

	sed -i -e "s|checkHandleIsValid|isValid|" \
		src/main/java/net/sf/hajdbc/state/bdb/BerkeleyDBStateManager.java \
		|| die "Failed to sed/update Berkeley DB api call"
}
