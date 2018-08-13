# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

MY_PN="${PN#*-}"
MY_PV="${PV//./_}"
MY_P="${MY_PN^^}_${MY_PV^^}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	MY_S="${PN}-${MY_P}"
fi

inherit java-pkg

DESCRIPTION="An ultra-thin bridge between different Java logging libraries"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	# Remove classes that go in commons-logging-adapters
	cd "${S}/src/main/java/org/apache/commons/logging/impl/" \
		|| die "Failed to change to adapaters directory"
	rm Avalon* Jdk13* Log4* LogKit* Servlet* Simple* \
		|| die "Failed to remove adapters"
}
