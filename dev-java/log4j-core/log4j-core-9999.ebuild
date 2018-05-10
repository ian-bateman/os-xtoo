# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/logging-log4j2"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="logging-log4j2-${MY_P}/"
fi

inherit java-pkg

DESCRIPTION="Apache Logging Log4J2 ${PN##*-}"

HOMEPAGE="https://logging.apache.org/log4j/"
LICENSE="Apache-2.0"
SLOT="0"

JACKSON_SLOT="2"

CP_DEPEND="
	dev-java/commons-compress:0
	dev-java/commons-csv:0
	dev-java/conversant-disruptor:0
	dev-java/disruptor:0
	dev-java/eclipse-javax-persistence:2
	dev-java/jackson-core:${JACKSON_SLOT}
	dev-java/jackson-annotations:${JACKSON_SLOT}
	dev-java/jackson-databind:${JACKSON_SLOT}
	dev-java/jackson-dataformat-xml:${JACKSON_SLOT}
	dev-java/jackson-dataformat-yaml:${JACKSON_SLOT}
	dev-java/jansi:0
	dev-java/javax-activation:0
	dev-java/javax-jms-api:2
	dev-java/jcommander:0
	dev-java/jctools-core:2
	dev-java/jeromq:0
	dev-java/kafka-clients:0
	~dev-java/log4j-api-${PV}:${SLOT}
	dev-java/javamail:0
	dev-java/osgi-core-api:6
	dev-java/stax2-api:0
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

S="${WORKDIR}/${MY_S}/${PN}"
