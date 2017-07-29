# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ ${PV} == *2017* ]]; then
	E_SNAP="b13596ac2c3b6685955f50c037f424c295408078"
fi

if [[ ${PV} == *2017* ]] || [[ ${PV} == 9999 ]]; then
	E_TYPE="tools"
else
	E_TYPE="apps"
fi

inherit e

DESCRIPTION="EFL Dynamic EDC editor"
HOMEPAGE="https://git.enlightenment.org/tools/${PV}.git/about/"
LICENSE="BSD-2"
