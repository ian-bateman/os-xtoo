# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^}2-J"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN,,}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P/2-/-}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN,,}-${MY_P/2-/-}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="XML parsers"
HOMEPAGE="https://xerces.apache.org/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

CP_DEPEND="dev-java/xml-commons-resolver:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f

	rm src/org/w3c/dom/html/HTMLDOMImplementation.java \
		|| die "Failed to remove legacy class"

	for f in IFrame Frame Object; do
		sed -i -e "20iimport org.w3c.dom.Document;" \
			-e "141i\ \ \ \ @Override" \
			-e "141i\ \ \ \ public Document getContentDocument() {" \
			-e "141i\ \ \ \ \ \ \ \ return(getOwnerDocument());" \
			-e "141i\ \ \ \ }" \
		"src/org/apache/html/dom/HTML${f}ElementImpl.java" \
		|| die "Failed to sed/add missing override HTML${f}ElementImpl"
	done
}
