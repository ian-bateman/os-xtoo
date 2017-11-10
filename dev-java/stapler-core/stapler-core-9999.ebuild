# Copyright 2016-2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:7}-parent"
MY_P="${MY_PN}-${PV}"

HOMEPAGE="https://github.com/${PN:0:7}/${PN:0:7}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}.git"
	MY_S="${P}/${PN:8}"
else
	SRC_URI="${HOMEPAGE}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN:0:7}-${MY_P}/${PN:8}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Stapler web framework ${PN:8}"
LICENSE="BSD-2-clause"
SLOT="0"

CP_DEPEND="
	dev-java/annotation-indexer:0
	dev-java/asm:5
	dev-java/commons-beanutils:0
	dev-java/commons-discovery:0
	dev-java/commons-fileupload:0
	dev-java/commons-io:0
	dev-java/jzlib:0
	dev-java/commons-lang:2
	dev-java/groovy:0
	dev-java/guava:23
	dev-java/jenkins-json-lib:2
	dev-java/jsr305:0
	dev-java/localizer:0
	dev-java/metainf-services:0
	dev-java/tiger-types:0
	dev-java/txw2-runtime:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}"

JAVA_SRC_DIR="src/main/java"

java_prepare() {
	sed -i -e "s|org.kohsuke.asm5|org.objectweb.asm|g" \
		"${S}/src/main/java/org/kohsuke/stapler/ClassDescriptor.java" \
		|| die "Could not sed asm"
}
