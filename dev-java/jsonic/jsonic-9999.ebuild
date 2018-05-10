# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Simple json encoder/decoder for java"
HOMEPAGE="https://jsonic.osdn.jp/"
LICENSE="Apache-2.0"
SLOT="0"

CP_DEPEND="
	dev-java/commons-beanutils:0
	dev-java/guice:4
	dev-java/tomcat-servlet-api:3.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${P}"

# Spring is packaged but to many deps, needs spring-web
JAVA_RM_FILES=(
	src/net/arnx/jsonic/web/extension/S2Container.java
	src/net/arnx/jsonic/web/extension/SpringContainer.java
)
