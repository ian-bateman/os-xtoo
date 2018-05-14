# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

DESCRIPTION="EOL Java Regular Expression"
HOMEPAGE="https://attic.apache.org/projects/${PN}.html"
SRC_URI="http://archive.apache.org/dist/${PV/-//}/${P}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"


S="${WORKDIR}/${P}"
