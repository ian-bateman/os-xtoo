# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="guava"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/google/${MY_PN}"

SLOT="${PV%%.*}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Guava InternalFutureFailureAccess and InternalFutures"
HOMEPAGE="https://github.com/google/guava"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/futures/${PN}"
