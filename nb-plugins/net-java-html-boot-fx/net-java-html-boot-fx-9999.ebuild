# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="incubator-netbeans-html4j"
MY_PV="release-${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

HOMEPAGE="${BASE_URI}"
DESCRIPTION="A presentation provider to show JavaFX WebView"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	~nb-plugins/net-java-html-${PV}:${SLOT}
	~nb-plugins/net-java-html-boot-${PV}:${SLOT}
	nb-ide/netbeans-openide-util-lookup:9
"

# Not ideal, binds to jdk 11, some may use 10, which this is ingored
COMMON_DEPEND="dev-java/openjfx-bin:11"

DEPEND="${CP_DEPEND}
	${COMMON_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	${COMMON_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN#*-*-*-}"

src_compile() {
	local openjfx

	if [[ java-pkg_get-vm-version != 10 ]]; then
		# not ideal but works, makes version moot
		openjfx=$( echo /opt/openjfx-bin-11*/lib/ )
		JAVAC_ARGS+=" --module-path=${openjfx}"
		JAVAC_ARGS+=" --add-modules=javafx.graphics "
		JAVAC_ARGS+=" --add-modules=javafx.web "
	fi
	java-pkg-simple_src_compile
}
