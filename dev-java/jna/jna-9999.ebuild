# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on ebuild from gentoo main tree
# Copyright 1999-2016 Gentoo Foundation

EAPI="6"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/java-native-access/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg-2 java-ant-2 ${ECLASS}

DESCRIPTION="Java Native Access"
HOMEPAGE="${BASE_URI}"
LICENSE="|| ( Apache-2.0 LGPL-2.1 )"
IUSE="+awt +nio-buffers"
SLOT="${PV%%.*}"

CP_DEPEND="dev-java/ant-core:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
	virtual/pkgconfig"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${P}"

JAVA_PKG_NO_CLEAN=0
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="native jar contrib-jars"
EANT_EXTRA_ARGS="-Ddynlink.native=true"

src_prepare() {
	default

	# delete bundled jars and copy of libffi
	# except native jars because build.xml needs them all
	find ! -path "./lib/native/*" -name "*.jar" -delete \
		|| die "Failed to remove jars"
	rm -r native/libffi || die "Failed to remove libffi"

	sed -i -e '\|<pathelement path="lib/clover.jar"/>|d' \
		-e '\|<copy todir="${build}/jws" file="lib/junit.jar"/>|d' \
		-e '\|<copy todir="${build}/jws" file="lib/clover.jar"/>|d' \
		build.xml || die "Failed to sed build.xml"

	if ! use awt ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_JAWT/g" native/Makefile \
			|| die "Failed to sed native/Makefile for AWT"
	fi

	if ! use nio-buffers ; then
		sed -i -E "s/^(CDEFINES=.*)/\1 -DNO_NIO_BUFFERS/g" \
			native/Makefile || die "Failed to sed native/Makefile"
	fi

	java-pkg-2_src_prepare
}

src_configure() {
	tc-export CC
}

src_install() {
	java-pkg_newjar build/${PN}-min.jar
	java-pkg_dojar contrib/platform/dist/${PN}-platform.jar
	java-pkg_doso build/native-*/libjnidispatch.so

	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc doc/javadoc
}
