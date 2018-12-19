# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jaf"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="JavaBeans Activation Framework"
HOMEPAGE="${BASE_URI}"
LICENSE="EDL-1.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN##*-}"
