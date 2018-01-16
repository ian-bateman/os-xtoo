# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

HOMEPAGE="https://github.com/cliftonlabs/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
#	EGIT_REPO_URI="${HOMEPAGE}.git"
	EGIT_REPO_URI="https://github.com/Obsidian-StudiosInc/json-simple.git"
	EGIT_BRANCH="JsonSimpleMessageBodyHandler"
	CP_DEPEND="dev-java/jax-rs:2"
	MY_S="${P}"
else
	KEYWORDS="~amd64"
	SRC_URI="${HOMEPAGE}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="A simple Java toolkit for JSON"
LICENSE="MIT"
if [[ ${PV} == 2* ]]; then
	SLOT="0"
else
	SLOT="${PV%%.*}"
fi

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"
