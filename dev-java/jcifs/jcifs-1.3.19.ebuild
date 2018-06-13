# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://jcifs.samba.org/"

CP_DEPEND="java-virtuals/servlet-api:4.0"

inherit java-pkg

DESCRIPTION="Library that implements the CIFS/SMB networking protocol in Java"
HOMEPAGE="${BASE_URI}"
SRC_URI="${BASE_URI}src/${P}.tgz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${P/-/_}"
