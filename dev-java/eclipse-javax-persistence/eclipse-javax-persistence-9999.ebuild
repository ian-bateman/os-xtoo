# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:8}"
MY_PN="${MY_PN/-/.}"
MY_PV="${PV/20/v20}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="Java Persistence API ${PV/.${PV#*.*.*}/} JSR-338 Implementation by Eclipselink"
HOMEPAGE="https://github.com/eclipse/${MY_PN}"
LICENSE="EDL-1.0 EPL-1.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/"
