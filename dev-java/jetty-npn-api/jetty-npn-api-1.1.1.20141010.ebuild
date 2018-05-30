# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

inherit java-pkg

MY_PN="${PN/jetty-/}"
MY_PV="${PV/2014/v2014}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Jetty's NPN API"
HOMEPAGE="https://wiki.eclipse.org/Jetty/Feature/NPN"
SRC_URI="https://repo1.maven.org/maven2/org/eclipse/${PN:0:5}/npn/${MY_PN}/${MY_PV}/${MY_P}-sources.jar"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" app-arch/unzip"
