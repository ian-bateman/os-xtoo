# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/_beta/-b}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Media Multipart"
HOMEPAGE="https://jersey.github.io/"
LICENSE="CDDL GPL-2-with-linking-exception"
SLOT="${PV%%.*}"

CP_DEPEND="
	dev-java/javax-inject:0
	dev-java/jax-rs:2.1
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-server-${PV}:${SLOT}
	dev-java/mimepull:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	dev-java/istack-commons-buildtools:0
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_P}/media/${PN##*-}"

java_prepare() {
	# Generate org.glassfish.jersey.internal.LocalizationMessages
	istack-cli -b "src/main/resources/" -d "src/main/java/" \
		-r "**/localization.properties" \
		-p "org.glassfish.jersey.internal.l10n" \
		|| die "Failed to generate java files from resources"
}
