# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN=${PN/aqute/aQute}
MY_PN=${MY_PN//-/.}

CP_DEPEND="dev-java/bndlib:4"

inherit java-pkg

DESCRIPTION="aQute JPM Clnt"
HOMEPAGE="https://github.com/bndtools/bnd/tree/4.0.0.DEV/cnf/repo/${MY_PN}"
SRC_URI="${HOMEPAGE/tree/blob}/${MY_PN}-${PV}.jar?raw=true -> ${P}.jar"
LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

DEPEND+=" app-arch/unzip:0"

S="${WORKDIR}/OSGI-OPT"

# Makes imports specific vs .*
# Change MultiMap.remove(K key, V value) -> remove(Object key, Object value)
# Per http://stackoverflow.com/questions/23785807/
# Compiles with patch, rename may have effect on dependencies using MultiMap

PATCHES=( "${FILESDIR}"/${P}-fix-imports.patch)

java_prepare() {
	sed -i -e "s|_)|v)|g" src/aQute/lib/collections/ExtList.java \
		|| die "Failed to sed/fix keyword _ -> v"

	sed -i -e "92d" src/aQute/lib/collections/MultiMap.java \
		|| die "Failed to sed/remove extra @Override"

	sed -i -e "s|, List<T>||" src/aQute/lib/collections/SortedList.java \
		|| die "Failed to sed/fix inherits unrelated defaults"
}
