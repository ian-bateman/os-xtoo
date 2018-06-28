# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${P/_/-}"

BASE_URI="https://github.com/google/auto/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="auto-${MY_P}"
fi

CP_DEPEND="
	dev-java/auto-common:0
	dev-java/auto-service:0
	dev-java/escapevelocity:0
	dev-java/guava:25
	dev-java/javapoet:0
"

inherit java-pkg

DESCRIPTION="Generated immutable value classes for Java 1.6+"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN##*-}/"

JAVA_RES_DIR="src/main/java"
