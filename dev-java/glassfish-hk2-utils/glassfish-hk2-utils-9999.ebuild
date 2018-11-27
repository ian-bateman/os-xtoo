# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*}"
MY_PV="${PV}-RELEASE"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse-ee4j/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/beanvalidation-api:1.1
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	dev-java/hibernate-validator-engine:5
"

inherit java-pkg

DESCRIPTION="Glassfish HK2 Implementation Utilities"
HOMEPAGE="https://hk2.java.net/"
LICENSE="EPL-2.0"

S="${WORKDIR}/${MY_P}/${PN:10}"
