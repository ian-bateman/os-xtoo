# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Relational database implemented entirely in Java"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_P}/java/${PN:6}"

java_prepare() {
	# Generated java file
	local sanity
	sanity="org/apache/derby/shared/common/sanity/SanityState"
	sed -i -e 's|@SANE@|false|g' "${sanity}.tmpl" \
		|| die "Could not sed ${sanity}.tmpl"

	mv "${sanity}.tmpl" "${sanity}.java" \
		|| die "Could not mv ${sanity}.tmpl -> ${sanity}.java"
}
