# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="plexus-containers"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/codehaus-plexus/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/plexus-classworlds:0
	dev-java/plexus-utils:0
	dev-java/guava:26
	dev-java/xbean-reflect:0
"

inherit java-pkg

DESCRIPTION="Plexus IoC Container core with companion tools"
HOMEPAGE="http://codehaus-plexus.github.io/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	find . -name '*est*.java' -delete || die "Failed to remove tests"
}
