# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:10}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/raphw/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Runtime code generation for the Java virtual machine."
HOMEPAGE="https://bytebuddy.net"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	dev-java/auto-common:0
	dev-java/auto-value:0
	dev-java/guava:23
	dev-java/spotbugs-annotations:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" -processor com.google.auto.value.processor.AutoAnnotationProcessor "

java_prepare() {
	local f

	for f in $(grep -l -m1 lombok\\.EqualsAndHashCode -r *); do
		sed -i -e "s|lombok.EqualsAndHashCode|com.google.auto.value.AutoValue|" \
			-e "s|@EqualsAndHashCode.*|@AutoValue|g" \
			"${f}" || die "Failed to swap lombok for autovalve"
	done
}
