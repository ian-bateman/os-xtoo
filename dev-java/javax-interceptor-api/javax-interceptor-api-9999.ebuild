# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-/.}"
MY_PN="${MY_PN%%-*}"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/javaee/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Project GlassFish Interceptor API"
HOMEPAGE="https://javaee.github.io/glassfish/"
LICENSE="CDDL GPL-2-with-classpath-exception"
SLOT="0"
