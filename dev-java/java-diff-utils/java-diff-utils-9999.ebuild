# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

CP_DEPEND="dev-java/jsr305:0"

inherit java-pkg

DESCRIPTION="Library for computing diffs, applying patches, generation side-by-side view"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-1.1"
SLOT="0"

S="${WORKDIR}/${MY_S}"
