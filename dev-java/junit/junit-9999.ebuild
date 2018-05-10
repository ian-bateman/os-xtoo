# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}"
MY_PV="r${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN}-team/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="A programmer-oriented testing framework for Java"
HOMEPAGE="https://junit.org/junit${SLOT}/"
LICENSE="EPL-1.0"

CP_DEPEND="dev-java/hamcrest-core:2"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	sed -i -e "s|<T> Matcher<Iterable<T>> everyItem(final Matcher<T>|<U> Matcher<Iterable<? extends U>> everyItem(final Matcher<U>|" \
		src/main/java/org/junit/matchers/JUnitMatchers.java \
		|| die "Failed to sed/fix type variable"
}
