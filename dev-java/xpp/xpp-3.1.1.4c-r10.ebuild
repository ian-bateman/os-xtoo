# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}"
MY_PV="${PV#*.}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://www.extreme.indiana.edu/"

inherit java-pkg

DESCRIPTION="Xml Pull Parser"
HOMEPAGE="${BASE_URI}xgws/xsoap/xpp/"
LICENSE="Apache-1.1 IBM"
KEYWORDS="~amd64"
case ${SLOT} in
	2)	MY_PN="PullParser${SLOT}"
		MY_P="${MY_PN}.${MY_PV}"
		SRC_URI="${BASE_URI}xgws/xsoap/${PN}/download/"
		SRC_URI+="${MY_PN}/${MY_P}.tgz -> ${P}.tar"
		CP_DEPEND="dev-java/xerces:2"
		;;
	3)	LICENSE+=" JDOM LGPL-2.1+"
		SRC_URI="${BASE_URI}dist/java-repository/"
		SRC_URI+="${MY_PN}/distributions/${MY_P}_src.tgz"
		;;
esac

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}"

JAVA_ENCODING="ISO-8859-1"
JAVAC_ARGS+=" --add-modules java.xml "

java_prepare() {
	rm -r src/java/{sample,test}s || die "Failed to remove samples,tests"

	if [[ "${SLOT}" == 2 ]]; then
		rm -r src/java/apis || die "Failed to remove apis"
		sed -i -e "s|enum|enumeration|g" \
			src/java/impl/node/org/gjt/xpp/impl/node/Node.java \
			|| die "Failed to sed/fix rename enum -> enumeration"
	fi
	if [[ "${SLOT}" == 3 ]]; then
		rm -r src/java/builder/javax \
			|| die "Failed to remove conflicting classes in jdk"
		rm -r src/java/xpath* || die "Failed to remove xpath"
	fi
}
