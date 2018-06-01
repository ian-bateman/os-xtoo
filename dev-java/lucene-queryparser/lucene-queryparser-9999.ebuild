# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="lucene-solr"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/releases/${MY_PN}/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-releases-${MY_P}"
fi

SLOT="${PV%%.*}"

CP_DEPEND="
	~dev-java/lucene-core-${PV}:${SLOT}
	~dev-java/lucene-queries-${PV}:${SLOT}
	~dev-java/lucene-sandbox-${PV}:${SLOT}
"

inherit java-pkg

DESCRIPTION="Java-based indexing and search technology ${PN:7}"
HOMEPAGE="https://lucene.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN//-//}"
