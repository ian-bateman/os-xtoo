# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV^^}"
MY_PV="${MY_PV/_/.}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/google/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
		  https://github.com/google/boringssl/archive/master.tar.gz -> boringssl-${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java Security Providere"
HOMEPAGE="https://conscrypt.org/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=virtual/jdk-9"

RDEPEND=">=virtual/jre-9"

S="${WORKDIR}/${MY_S}/"

JAVA_SRC_DIR="common/src/main/java openjdk/src/main/java"
JAVAC_ARGS+="--add-exports=java.base/sun.security.x509=ALL-UNNAMED "
#JAVAC_ARGS="--add-modules java.base"

java_prepare() {
	# Google insanity....
	# Compile program to generate NativeConstants.java what?
	gcc -I"${WORKDIR}/boringssl-master/include" \
		constants/src/gen/cpp/generate_constants.cc \
		|| die "Failed to compile generate_constants.cc"

	# Run program to generate NativeConstants.java what?
	"${S}/a.out" > "${S}/common/src/main/java/org/conscrypt/NativeConstants.java" \
		|| die "Failed exe generate_constants for NativeConstants.java"
}
