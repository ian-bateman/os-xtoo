# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/hierynomus/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"
BCV="1.60"

CP_DEPEND="
	dev-java/bcpkix:${BCV}
	dev-java/bcprov:${BCV}
	dev-java/ed25519-java:0
	dev-java/jaxb-api:0
	dev-java/jzlib:0
	dev-java/slf4j-api:0
"

inherit java-pkg

DESCRIPTION="SSHv2 library ssh, scp, and sftp for java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

S="${WORKDIR}/${P}"
