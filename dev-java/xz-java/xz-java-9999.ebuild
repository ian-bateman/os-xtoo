# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
EGIT_REPO_URI="https://git.tukaani.org/xz-java.git"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://tukaani.org/xz/${P}.zip"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="XZ data compression in pure Java"
HOMEPAGE="https://tukaani.org/xz/java.html"
LICENSE="public-domain"
SLOT="0"

JAVA_SRC_DIR="src/org"
