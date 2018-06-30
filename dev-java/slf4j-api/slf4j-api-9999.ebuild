# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="v_${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/qos-ch/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Simple Logging Facade for Java - ${PN##*-}"
HOMEPAGE="https://www.slf4j.org/"
LICENSE="MIT"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

src_compile() {
	JAVA_NO_JAR=0
	java-pkg-simple_src_compile
	# Needed per https://github.com/Obsidian-StudiosInc/os-xtoo/issues/43
	rm -r target/classes/org/slf4j/impl/ \
		|| die "Remove code that should never make it into the jar"
	java-pkg-simple_create-jar target/classes
}
