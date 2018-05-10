# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/kohsuke/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg

DESCRIPTION="Library to perform type arithemtic over the type system"
HOMEPAGE="https://github.com/kohsuke/${PN}"
LICENSE="|| ( CDDL GPL-2-with-classpath-exception )"
SLOT="0"

DEPEND=">=virtual/jdk-9"
RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|Void _|Void vvoid|g" \
		src/main/java/org/jvnet/tiger_types/Types.java \
		|| die "Failed to sed/fix Java 9 keyword _ -> vvoid"
}
