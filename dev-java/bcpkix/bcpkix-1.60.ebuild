# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN}-jdk15on-${PV/./}"
BASE_URI="https://www.bouncycastle.org/"

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="dev-java/bcprov:${SLOT}"

inherit java-pkg

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="${BASE_URI}java.html"
SRC_URI="${BASE_URI}download/${MY_P}.tar.gz"
KEYWORDS="~amd64"
LICENSE="BSD"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_P}"

JAVA_RM_FILES=(
	tsp pkcs operator openssl mozilla est eac dvcs cms cert cert/path
	cert/ocsp cert/crmf cert/cmp
)
JAVA_RM_FILES=(${JAVA_RM_FILES[@]/#/org/bouncycastle/})
JAVA_RM_FILES=(${JAVA_RM_FILES[@]/%//test})

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}
