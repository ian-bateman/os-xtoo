# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:10:3}"
MY_PV="${PV%*_beta*}-b$( printf "%02d" ${PV#*_beta*})"
MY_P="${MY_PN}-${MY_PV}"

SLOT="0"

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="Glassfish HK2 OSGi Resource Locator"
HOMEPAGE="https://hk2.java.net/"
SRC_URI="https://github.com/${MY_PN}-project/${MY_PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="CDDL GPL-2-with-linking-exception"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}/${PN:14}"
