# Copyright 2015-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit perl-module

DESCRIPTION="CLI to the Linode platform."
HOMEPAGE="https://github.com/linode/cli"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="dev-perl/Crypt-SSLeay
	dev-perl/JSON
	dev-perl/Mozilla-CA
	dev-perl/Try-Tiny
	dev-perl/WebService-Linode"

DEPEND="${RDEPEND}"

S="${WORKDIR}/cli-${PV}"
