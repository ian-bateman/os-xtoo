# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/javax-jms-api:2
	dev-java/javamail:0
"

inherit java-pkg

DESCRIPTION="Java-based logging utility"
HOMEPAGE="https://logging.apache.org/log4j/"
SRC_URI="https://archive.apache.org/dist/logging/${PN}/${PV}/${P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/apache-${P}"
