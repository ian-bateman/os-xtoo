# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg

DESCRIPTION="FTP client library"
HOMEPAGE="https://enterprisedt.com/products/${PN}/"
SRC_URI="${HOMEPAGE}download/${PN}.zip -> ${P}.zip"
KEYWORDS="~amd64"
LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND+="app-arch/unzip"

S="${WORKDIR}/${P}"

JAVA_RM_FILES=( src/com/enterprisedt/net/ftp/test )
