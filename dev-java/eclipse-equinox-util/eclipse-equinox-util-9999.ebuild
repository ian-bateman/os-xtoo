# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="rt.equinox.bundles"
MY_PN="${MY_PN//-/.}"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Eclipse Equinox Util"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	~dev-java/eclipse-osgi-services-${PV}:${SLOT}
	dev-java/osgi-core-api:6
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

java_prepare() {
	local f
	for f in event/EventThread \
		impl/tpt/timer/TimerImpl \
		impl/tpt/threadpool/Executor; do
		sed -i -e "s|Exception _|Exception e|" \
			src/org/eclipse/equinox/internal/util/${f}.java \
			|| die "Failed to sed Java 9 keyword _ -> e"
	done
}
