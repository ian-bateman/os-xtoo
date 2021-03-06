# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/javax-jms-api:2
	dev-java/javamail:0
	dev-java/log4j:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="EOL Java logging toolkit"
HOMEPAGE="https://excalibur.apache.org/"
SRC_URI="https://archive.apache.org/dist/excalibur/excalibur-logkit/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P}"

PATCHES=( "${FILESDIR}/java_update.patch" )
