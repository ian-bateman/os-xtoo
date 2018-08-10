# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="OpenPDF"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/LibrePDF/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

BCV="1.60"

CP_DEPEND="
	dev-java/bcpkix:${BCV}
	dev-java/bcprov:${BCV}
	dev-java/commons-compress:0
	dev-java/commons-imaging:0
	dev-java/commons-io:0
	dev-java/commons-text:0
	dev-java/juniversalchardet:0
"

inherit java-pkg

DESCRIPTION="Java PDF library, forked from iText"
HOMEPAGE="${BASE_URI}"
LICENSE="MPL-2.0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	local f

	for f in $(grep -l -m1 sanselan -r src/main/java); do
		sed -i -e "s|.sanselan.|.commons.imaging.|g" "${f}" \
			-e "s|.byteSources.|.bytesource.|g" \
			|| die "Failed to sed/replace import"
	done
}
