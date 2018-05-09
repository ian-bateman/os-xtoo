# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit toolchain-funcs

DESCRIPTION="A java extension of BSD YACC-compatible parser generator"
HOMEPAGE="http://byaccj.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}${PV}_src.tar.gz"
LICENSE="public-domain"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	cp "${FILESDIR}/Makefile" src/Makefile || die
	emake CC="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS}" \
		CFLAGS="${CFLAGS}" -C src linux
}

src_install() {
	newbin src/yacc.linux "${PN}"
}
