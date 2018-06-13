# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: gradle.eclass
#
# @MAINTAINER:
# William L. Thomson Jr. <wlt@o-sinc.com>
#
# @AUTHOR:
# William L. Thomson Jr. <wlt@o-sinc.com>
#
# @BLURB: Eclass for Gradle Packages
# @DESCRIPTION:
# This eclass should be inherited for gradle-* packages.
# No other eclass need be inherited.

MY_PN="gradle"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://gradle.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN#*-}"

EXPORT_FUNCTIONS src_prepare

# @FUNCTION: gradle_src_prepare
# @DESCRIPTION:
# Creates generated ${PN}-classpath.properties

gradle_src_prepare() {
	local dep projects res runtime

	java-pkg_src_prepare

	res="src/main/resources"
	if [[ ! -d "${res}" ]]; then
		mkdir -p "${res}" || die "Failed to make ${res} directory"
	fi

	for dep in ${CP_DEPEND[@]}; do
		dep="${dep/*dev-java\//}"
		dep="${dep/-${PV}/}"
		dep="${dep/:*/}"
		case "${dep}" in
			gradle-*) projects+="${dep}," ;;
			*) runtime+="${dep}," ;;
		esac
	done
	echo "projects=${projects%*,}
runtime=${runtime%*,}" > src/main/resources/${PN}-classpath.properties \
		|| die "Failed to generate ${PN}-classpath.properties"
}
