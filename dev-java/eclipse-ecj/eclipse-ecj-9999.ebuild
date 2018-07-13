# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.jdt.core"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

# antadapter deps
#CP_DEPEND="
#	dev-java/ant-core:0
#	~dev-java/eclipse-jdt-core-${PV}:${SLOT}
#"

inherit java-pkg

DESCRIPTION="JDT Core Compiler aka Eclipse Compiler for Java"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${MY_PN}/"

# Upstream jar has antadapter we should as well, but lots of deps
#JAVA_SRC_DIR="antadapter batch compiler ../eclipse.jdt.core/src"
JAVA_SRC_DIR="batch compiler ../eclipse.jdt.core/src"
JAVA_RES_DIR="resources"

java_prepare() {
	local f p

	p="org/eclipse/jdt/internal/compiler"
	mkdir -p resources/${p}/{batch,parser,parser/unicode,parser/unicode6,parser/unicode6_2,problem} \
		|| die "Failed to make resources directories"

	cp {batch,resources}/${p}/batch/messages.properties \
		|| die "Failed to copy ${f}messages.properties"

	for f in "" "problem/"; do
		cp {compiler,resources}/${p}/${f}messages.properties \
			|| die "Failed to copy ${f}messages.properties"
	done

	for f in parser{,/unicode,/unicode6,/unicode6_2}; do
		cp -r compiler/${p}/${f}/* resources/${p}/${f} \
			|| die "Failed to copy ${f}/*"
	done
}
