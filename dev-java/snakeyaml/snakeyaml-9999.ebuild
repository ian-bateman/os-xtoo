# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://bitbucket.org/asomov/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/get/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

inherit java-pkg

DESCRIPTION="YAML 1.1 parser and emitter for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-10"
RDEPEND=">=virtual/jre-10"

S="${WORKDIR}/${MY_S}"

src_unpack() {
	default
	# bitbucket uses commit hash vs version
	if [[ ${PV} != *9999* ]]; then
		cd "${WORKDIR}" || die "Failed to change to ${WORKDIR}"
		mv * ${MY_S} || die "Failed to mv/rename src dir"
	fi
}
