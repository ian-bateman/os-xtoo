# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

CP_DEPEND="dev-java/xerces:2"

inherit java-pkg

DESCRIPTION="Open Java API for OLAP"
HOMEPAGE="https://www.${PN}.org/"
LICENSE="Apache-2.0"
SLOT="0"

JDK_VERSION="1.8"

DEPEND+=" dev-java/javacc:0"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src"

java_prepare() {
	# remove jdbc 3/1.5 4.0/1.6
	rm -v "${S}/src/org/olap4j/driver/xmla/FactoryJdbc3Impl.java" \
		"${S}/src/org/olap4j/driver/xmla/FactoryJdbc4Impl.java" \
		|| die "Could not remove FactoryJdbc{3,4}Impl.java"

	# set version and timestamp
	local my_file my_path
	my_file="XmlaOlap4jDriverVersion.java"
	my_path="${S}/src/resources/version/"
	sed -i -e "s|@pomversion@|${PV}|" \
		-e "s|@buildtime@|$(date)|" \
		"${my_path}/${my_file}.template" \
		|| die "Could not set version & timestamp"

	# move/rename version template to java
	mv "${my_path}/${my_file}.template" \
		"${S}/src/org/olap4j/driver/xmla/${my_file}" \
		|| die "Could not move/rename template"

	cd "${S}/src/org/olap4j/mdx/parser/impl/"
	javacc -JDK_VERSION="${JDK_VERSION}" MdxParser.jj \
		|| die "javacc MdxParser.jj failed "
}
