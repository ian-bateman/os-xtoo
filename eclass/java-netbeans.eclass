# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-netbeans.eclass
# @MAINTAINER: William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR: William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Netbeans IDE common code

if [[ -z ${_E_ECLASS} ]]; then
_E_ECLASS=1

MY_PN="incubator-${PN%%-*}"
MY_PV="${PV//_/-}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN#*-}"
MY_MOD="${MY_MOD//-/.}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Netbeans IDE"
HOMEPAGE="https://netbeans.org"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
SLOT="${PV%%.*}"
S="${WORKDIR}/${MY_S}/${MY_MOD}"

fi
