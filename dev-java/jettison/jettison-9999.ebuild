# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}-json/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Library for converting XML to JSON and vice-versa using StAX"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|Object, Object> jnsToXns = new HashMap<Object|String, Object> jnsToXns = new HashMap<String|" \
		-e "s|jnsToXns.put(|jnsToXns.put((String)|" \
		-e "s|Iterator<Object>|Iterator<String>|g" \
		-e "s|emptySet|<String>emptySet|" \
		src/main/java/org/codehaus/jettison/mapped/MappedNamespaceConvention.java \
		|| die "Failed to sed/fix java 10 type change"
}
