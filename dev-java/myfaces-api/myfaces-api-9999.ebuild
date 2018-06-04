# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%*-}-core-module"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN##*-}"
BASE_URI="https://github.com/apache/${PN%%-*}"

if [[ ${PV} == 9999 ]]; then
	MY_S="${P}/${MY_MOD}"
else
	# github missing tags? upstream source tarball is rebundled, thus maven
	SRC_URI="http://repo1.maven.org/maven2/org/apache/${PN%%-*}/core/${PN}/${PV/_/-}/${PN}-${PV/_/-}-sources.jar"
#	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
#	MY_S="${PN}-${MY_P}/${MY_MOD}"
fi

SLOT="0"

CP_DEPEND="
	dev-java/beanvalidation-api:2.0
	dev-java/cdi-api:0
	dev-java/javax-inject:0
	dev-java/myfaces-builder-annotations:0
	dev-java/taglibs-standard-spec:0
	dev-java/tomcat-servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Open-source JavaServer Faces implementation - ${MY_MOD}"
HOMEPAGE="https://myfaces.apache.org/"
LICENSE="Apache-2.0"

DEPEND+=" app-arch/unzip"

S="${WORKDIR}/${MY_S}"
