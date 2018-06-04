# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="org.osgi.service.obr"
MY_P="${MY_PN}-${PV}"

CP_DEPEND="dev-java/osgi-core-api:6"

inherit java-pkg

DESCRIPTION="OSGi Service OBR by Apache"
HOMEPAGE="https://felix.apache.org"
SRC_URI="mirror://apache/dist/felix/${MY_P}-project.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${MY_P}"
