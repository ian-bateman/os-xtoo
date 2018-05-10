# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

DESCRIPTION="reCAPTCHA Library for Java"
HOMEPAGE="https://github.com/kohsuke/${PN}"
SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${PN}-${P}"

JAVA_SRC_DIR="src/main/java"
