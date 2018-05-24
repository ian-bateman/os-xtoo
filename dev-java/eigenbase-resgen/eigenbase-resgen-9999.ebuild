# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/julianhyde/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/eigenbase-xom:0
"

inherit java-pkg

DESCRIPTION="Generator of type-safe wrappers for Java resource files"
HOMEPAGE="https://www.hydromatic.net/${PN:10}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"
