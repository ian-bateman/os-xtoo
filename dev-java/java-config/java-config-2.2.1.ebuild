# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

# jython depends on java-config, so don't add it or things will break
#PYTHON_COMPAT=( python{2_7,3_3,3_4} )

#inherit distutils-r1

DESCRIPTION="Java environment configuration query tool (meta package installs nothing)"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Java"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64"

# baselayout-java is added as a dep till it can be added to eclass.
#	>=dev-java/java-config-wrapper-0.15
#	sys-apps/baselayout-java
RDEPEND="sys-apps/portage"

#python_test() {
#	esetup.py test || die
#}
