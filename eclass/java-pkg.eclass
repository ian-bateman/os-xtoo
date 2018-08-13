# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on java-pkg-2.eclass
# Copyright 2004-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-pkg.eclass
# @MAINTAINER:
# William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR:
# William L. Thomson Jr. <wlt@o-sinc.com>
# @BLURB: Eclass for Java Packages
# @DESCRIPTION:
# This eclass should be inherited for pure Java packages, or by packages which
# need to use Java. No other eclass need be inherited.

inherit java-utils-2 java-pkg-simple

# @ECLASS-VARIABLE: JAVA_PKG_IUSE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Use JAVA_PKG_IUSE instead of IUSE for doc, source and examples so that
# the eclass can automatically add the needed dependencies for the java-pkg_do*
# functions.
IUSE="${JAVA_PKG_IUSE}"

# JAVA_PKG_E_DEPEND is defined in java-utils-2.eclass.
DEPEND="${JAVA_PKG_E_DEPEND}"

# Nothing special for RDEPEND... just the same as DEPEND.
RDEPEND="${DEPEND}"

if [[ ${PV} == *9999* ]] && \
( [[ ${BASE_URI} ]] || [[ ${EGIT_REPO_URI} ]] ); then
        EGIT_REPO_URI="${EGIT_REPO_URI:-${BASE_URI}.git}"
	MY_S="${P}"
        inherit git-r3
fi

if [[ ${PV} != *9999* ]]; then
	: ${KEYWORDS:="~amd64"}
fi

EXPORT_FUNCTIONS pkg_setup src_prepare pkg_preinst

# @FUNCTION: java-pkg_pkg_setup
# @DESCRIPTION:
# pkg_setup initializes the Java environment

java-pkg_pkg_setup() {
	java-pkg_init
}


# @FUNCTION: java-pkg_src_prepare
# @DESCRIPTION:
# wrapper for java-utils-2_src_prepare

java-pkg_src_prepare() {
	java-utils-2_src_prepare
}


# @FUNCTION: java-pkg_pkg_preinst
# @DESCRIPTION:
# wrapper for java-utils-2_pkg_preinst

java-pkg_pkg_preinst() {
	java-utils-2_pkg_preinst
}
