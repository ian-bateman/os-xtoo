# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

E_BUILD="meson"
E_SNAP="${P}"
E_TARBALL="tar.gz"
E_TYPE="enlightenment/modules"

inherit e

DESCRIPTION="Insanity for your E desktop"
HOMEPAGE="${E_GIT_URI}/${E_TYPE}/${PN}.git"
LICENSE="BSD"
