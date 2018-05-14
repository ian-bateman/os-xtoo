# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN//-/.}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	if [[ ${PV} == *201710* ]]; then
		MY_SNAP="9bccc39883da8a9910bcee5a8f04f0fec1230a35"
		SRC_URI="${BASE_URI}/archive/${MY_SNAP}.tar.gz -> ${P}.tar.gz"
		MY_S="${MY_PN}-${MY_SNAP}"
	else
		SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
		MY_S="${MY_P}"
	fi
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Java EE Web Services Metadata API"
HOMEPAGE="${BASE_URI}"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"

S="${WORKDIR}/${MY_S}"
