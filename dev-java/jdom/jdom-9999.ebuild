# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/hunterhacker/${PN}"

if [[ ${PV} != *9999* ]]; then
	MY_S="${PN}"
	if [[ ${PV} == 1* ]]; then
		SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	else
		SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
		MY_S+="-${MY_P}"
	fi
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Manipulation of XML made easy"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-1.1"

S="${WORKDIR}/${MY_S}/"

if [[ ${PV} == 1* ]]; then
	SLOT="0"
else
	SLOT="${PV%%.*}"
	MY_SLOT="${SLOT}"
	S+="core"
fi

JAVA_RM_FILES="src/java/org/jdom${MY_SLOT}/xpath"

java_prepare() {
	if [[ ${PV} == 2* ]]; then
		sed -i -e "/XPathFactory;/d" \
			src/java/org/jdom2/JDOMConstants.java \
			|| "Failed to remove jaxen import"
	fi
}
