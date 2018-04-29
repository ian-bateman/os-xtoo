# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/square/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/parent-${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P/${PN}/${PN}-parent}"
fi

inherit java-pkg

DESCRIPTION="HTTP client that's efficient by default"
HOMEPAGE="https://square.github.io/okhttp/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="dev-java/okio:0"

if [[ ${PV} == 3* ]]; then
	SLOT="3"
	CP_DEPEND+="
		dev-java/jsr305:0
		dev-java/conscrypt:0
	"
fi

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_SRC_DIR="
	src/main/java
	src/main/java-templates
"

java_prepare() {
	if [[ ${PV} == 2* ]]; then
		sed -i -e '19d' -e '129,170d' -e '199,330d' \
			src/main/java/com/squareup/okhttp/internal/Platform.java \
			|| die "Failed to sed remove Android support"
	fi
	if [[ ${PV} == 3* ]]; then
		rm src/main/java/okhttp3/internal/platform/AndroidPlatform.java \
			|| die "Failed to remove Android support"
		sed -i -e "199,203d" \
			src/main/java/okhttp3/internal/platform/Platform.java \
			|| die "Failed to sed remove Android support"
	fi
}
