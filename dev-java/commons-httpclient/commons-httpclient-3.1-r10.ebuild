# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

CP_DEPEND="
	dev-java/commons-codec:0
	dev-java/commons-logging:0
"

inherit java-pkg

DESCRIPTION="EOL Commons HttpClient library"
HOMEPAGE="https://hc.apache.org/httpclient-3.x/"
SRC_URI="mirror://apache/httpcomponents/${PN}/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="src/java"
