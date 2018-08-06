# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="ocs-url"
MY_PV="release-${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

DESCRIPTION="An install helper program for desktop stuff"
HOMEPAGE="${BASE_URI}/wiki"
SRC_URI="${BASE_URI}/archive/release-${PV}.tar.gz -> ${MY_P}.tar.gz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_P}/"
