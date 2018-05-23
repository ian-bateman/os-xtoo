# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN^^}"
MY_PV="${PV//./_}"
MY_P="${MY_PN}_${MY_PV}"

BASE_URI="https://gitlab.ow2.org/asm/asm"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/repository/ASM_6_1_1/archive.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

CP_DEPEND="
	dev-java/aqute-jpm-clnt:0
	dev-java/bndlib:4
"

inherit java-pkg

DESCRIPTION="Java bytecode manipulation framework"
HOMEPAGE="http://forge.ow2.org/projects/asm/"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="
	asm/src/main/java
	asm-analysis/src/main/java
	asm-commons/src/main/java
	asm-tree/src/main/java
	asm-util/src/main/java
	asm-xml/src/main/java
"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
		default
	else
		local tgz
		tgz="${P}.tar.gz"
		mkdir -p "${S}" || die "Failed to mkdir ${S}"
		echo ">>> Unpacking ${tgz} to ${PWD}"
		tar -xzf "${DISTDIR}/${tgz}" --strip-components=1 -C "${S}" \
			|| die "Failed to unpack ${DISTDIR}/${tgz}"
	fi
}
