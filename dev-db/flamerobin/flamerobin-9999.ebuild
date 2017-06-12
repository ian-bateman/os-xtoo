# Copyright 2016 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/mariuz/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/mariuz/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

WX_GTK_VER="3.0-gtk3"

inherit eutils wxwidgets ${ECLASS}

DESCRIPTION="A database administration tool for Firebird DBMS"
HOMEPAGE="https://www.flamerobin.org/"

LICENSE="MIT IBPP-1.1 LGPL-2.1+"
SLOT="0"
IUSE="doc"

RDEPEND="x11-libs/wxGTK:${WX_GTK_VER}[X]
	 dev-db/firebird"

DEPEND="${RDEPEND}"

[[ ${PV} == 9999 ]] && DEPEND="app-arch/unzip ${DEPEND}"

src_prepare() {
	default
	sed -i -e \
		's|flamerobin.png $(DESTDIR)$(datadir)/pixmaps)|fricon128.png $(DESTDIR)$(datadir)/pixmaps/flamerobin.png)|' \
		"${S}/Makefile.in" \
		|| die "Could not sed/swap icon"
}

src_configure() {
	# temp hack since configure is not executable
	chmod +x configure

	local myconf
	myconf="${myconf} \
		--disable-shared \
		--disable-debug \
		--with-wx=yes \
		--with-wx-config=${WX_CONFIG}"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc devdocs/* docs/* docs-src/*
}
