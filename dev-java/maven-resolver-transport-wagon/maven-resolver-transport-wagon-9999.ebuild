# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%-*-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/javax-inject:0
	~dev-java/maven-resolver-api-${PV}:${SLOT}
	~dev-java/maven-resolver-spi-${PV}:${SLOT}
	~dev-java/maven-resolver-util-${PV}:${SLOT}
	dev-java/maven-wagon-provider-api:0
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:0
	dev-java/plexus-container-default:0
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Apache Maven Resolver ${PN#*-*-}"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}"
