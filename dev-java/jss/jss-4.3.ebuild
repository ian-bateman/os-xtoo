# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_P="${PN^^}_${PV//./_}"

inherit java-pkg

DESCRIPTION="Netscape Directory SDK for Java"
HOMEPAGE="https://www-archive.mozilla.org/directory/javasdk.html"
SRC_URI="http://ftp.mozilla.org/pub/security/jss/releases/${MY_P}_RTM/src/${P}.tar.bz2"
KEYWORDS="~amd64"
LICENSE="MPL-1.1"
SLOT="0"

S="${WORKDIR}/mozilla/security/jss"

JAVA_SRC_DIR="org"

java_prepare() {
	mv org/mozilla/jss/util/Debug{_ship.jnot,.java} \
		|| die "Failed to rename file"
}
