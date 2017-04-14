# Copyright 2017 Obisidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Tidbits from enlightenment.eclass
# Copyright 1999-2014 Gentoo Foundation

# @ECLASS: e.eclass
# @MAINTAINER: wlt@o-sinc.com
# @BLURB: Enlightenment package management common code

if [[ -z ${_E_ECLASS} ]]; then
_E_ECLASS=1

inherit eutils libtool

# @ECLASS-VARIABLE: E_TYPE
# @DEFAULT_UNSET
# @DESCRIPTION:
# if defined, the type of package, apps, bindings, tools

# @ECLASS-VARIABLE: E_BASE_URI
# @DESCRIPTION:
# default url for enlightenment git repos
E_BASE_URI=${E_BASE_URI:="enlightenment.org"}

# @ECLASS-VARIABLE: E_GIT_URI
# @DESCRIPTION:
# default url for enlightenment git repos
E_GIT_URI=${E_GIT_URI:="https://git.${E_BASE_URI}"}

# @ECLASS-VARIABLE: E_ECONF
# @DESCRIPTION:
# Array of flags to pass to econf (obsoletes MY_ECONF)
E_ECONF=()

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="${E_GIT_URI}/${E_TYPE}/${PN}.git"
	SLOT="${PV}"
	WANT_AUTOCONF=latest
	WANT_AUTOMAKE=latest
	inherit autotools git-r3
else
        SRC_URI="https://download.${E_BASE_URI}/rel/${E_TYPE}/${PN}/${P/_/-}.tar.gz"
	KEYWORDS="~amd64"
	SLOT="0"
fi

CDEPEND="dev-libs/efl"
DEPEND="${CDEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${CDEPEND}
	nls? ( sys-devel/gettext )"
IUSE="nls doc static-libs"
S="${WORKDIR}/${P/_/-}"

EXPORT_FUNCTIONS src_prepare src_configure src_install

# @FUNCTION: e_src_prepare
# @DESCRIPTION:
# default src_prepare for e ebuilds
e_src_prepare() {
	debug-print-function ${FUNCNAME} $*
	default
	if [[ ${PV} == 9999 ]]; then
		ewarn "ran eautopoint"
		eautoreconf
	fi
	epunt_cxx
	elibtoolize
}

e_src_configure() {
	debug-print-function ${FUNCNAME} $*
        has nls ${IUSE} && \
		E_ECONF+=( $(use_enable nls) )
        has static-libs ${IUSE} && \
		E_ECONF+=( $(use_enable static-libs static) )

        econf ${MY_ECONF} "${E_ECONF[@]}"
}

e_src_install() {
	debug-print-function ${FUNCNAME} $*
	default
	prune_libtool_files
}

fi
