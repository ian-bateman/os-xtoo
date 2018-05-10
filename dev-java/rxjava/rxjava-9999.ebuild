# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="RxJava"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/ReactiveX/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Adapter between RxJava and ReactiveStreams"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"

if [[ ${PV} == 1* ]]; then
	SLOT="0"
	JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
else
	SLOT="${PV%%.*}"
	CP_DEPEND="dev-java/reactive-streams:0"
fi

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/"

java_prepare() {
	if [[ ${PV} == 1* ]]; then
		sed -i -e "569s|return from|return (Single<T>)from|" \
			src/main/java/rx/Single.java \
			|| die "Failed to sed/fix java9 type"
	fi
}
