# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="JCTools"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Java Concurrency Tools"
HOMEPAGE="https://jctools.github.io/${MY_PN}/"
LICENSE="Apache-2.0"

if [[ ${PV} == 1* ]]; then
	SLOT="0"
else
	SLOT="2"
fi

RDEPEND=">=virtual/jre-9"
DEPEND=">=virtual/jdk-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
