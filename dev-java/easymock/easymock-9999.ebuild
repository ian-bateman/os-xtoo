# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Mocking easier"
HOMEPAGE="http://easymock.org"
LICENSE="Apache-2.0"
SLOT="0"

#	dev-java/dexmaker:0
CP_DEPEND="
	dev-java/cglib:3
	dev-java/junit:4
	dev-java/objenesis:2
	dev-java/testng:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/core"

java_prepare(){
	# need to package org.droidparts.dexmaker.stock.ProxyBuilder
	rm src/main/java/org/easymock/internal/AndroidClassProxyFactory.java \
		|| die "Failed to remove AndroidClassProxyFactory.java"
	sed -i -e '150,154d' \
		src/main/java/org/easymock/internal/MocksControl.java \
		|| die "Failed to sed remove AndroidClassProxyFactory usage"
}
