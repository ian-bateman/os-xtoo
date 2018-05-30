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

SLOT="${PV%%.*}"

NETTY_SLOT="4.1"

CP_DEPEND="
	dev-java/javax-inject:0
	dev-java/jax-rs:2.1
	~dev-java/jersey-core-common-${PV}:${SLOT}
	~dev-java/jersey-core-client-${PV}:${SLOT}
	dev-java/netty-buffer:${NETTY_SLOT}
	dev-java/netty-codec:${NETTY_SLOT}
	dev-java/netty-codec-http:${NETTY_SLOT}
	dev-java/netty-common:${NETTY_SLOT}
	dev-java/netty-handler:${NETTY_SLOT}
	dev-java/netty-handler-proxy:${NETTY_SLOT}
	dev-java/netty-transport:${NETTY_SLOT}
"
inherit java-pkg

DESCRIPTION="Jersey RESTful Web Services in Java Connector Netty"
HOMEPAGE="https://jersey.github.io/"
LICENSE="CDDL GPL-2-with-linking-exception"

DEPEND+=" dev-java/istack-commons-buildtools:0"

S="${WORKDIR}/${MY_P}/connectors/${PN#*-*-}-connector"

java_prepare() {
	# Generate org.glassfish.jersey.internal.LocalizationMessages
	istack-cli -b "src/main/resources/" -d "src/main/java/" \
		-r "**/localization.properties" \
		-p "org.glassfish.jersey.internal.l10n" \
		|| die "Failed to generate java files from resources"
}
