# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-jdk15on-${PV/./}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="https://www.bouncycastle.org/java.html"
SRC_URI="https://www.bouncycastle.org/download/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64"
SLOT="$(get_version_component_range 1-2)"

DEPEND=">=virtual/jdk-1.8
	app-arch/unzip"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}"

JAVA_ENCODING="ISO-8859-1"

src_unpack() {
	default
	cd "${S}" || die
	unpack ./src.zip
}

java_prepare() {
	# There are too many files to delete so we won't be using JAVA_RM_FILES
	# (it produces a lot of output).
	local RM_TEST_FILES=()
	while read -d $'\0' -r file; do
		RM_TEST_FILES+=("${file}")
	done < <(find . -name "*Test*.java" -type f -print0)
	while read -d $'\0' -r file; do
		RM_TEST_FILES+=("${file}")
	done < <(find . -name "*Mock*.java" -type f -print0)

	rm -v "${RM_TEST_FILES[@]}" || die

	sed -i -e "s|drbg.reseed(null)|drbg.reseed((byte[])null)|" \
		org/bouncycastle/jcajce/provider/drbg/DRBG.java \
		|| die "Failed to fix for abiguous java 9"
}
