# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

if [[ ${PV} == 9999 ]]; then
	ECLASS="subversion"
	ESVN_REPO_URI="https://svn.code.sf.net/p/loggifier/code/de.unkrig.commons/trunk/${PN}"
	S="${WORKDIR}/${P}"
else
	SRC_URI="http://repo1.maven.org/maven2/de/unkrig/${PN%%-*}/${PN}/${PV}/${P}-sources.jar"
	KEYWORDS="~amd64"
fi

inherit java-pkg ${ECLASS}

DESCRIPTION="Annotations and utility classes for annotation-base null analysis"
HOMEPAGE="http://unkrig.de/w/Commons.unkrig.de#${PN}"
LICENSE="BSD"
SLOT="0"
