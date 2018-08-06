# Copyright 2015-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils flag-o-matic

MY_PV="${PV%.*}"
MY_PN="OdbcJdbc"
MY_P="${MY_PN}-src-${PV}"

DESCRIPTION="ODBC driver for Firebird RDBMS"
HOMEPAGE="https://firebirdsql.org/index.php?op=files&id=odbc"
SRC_URI="mirror://sourceforge/project/firebird/firebird-ODBC-driver/${MY_PV}-Release/${MY_P}.tar.gz"
LICENSE="IDPL"
SLOT="0"

KEYWORDS="~amd64"
IUSE="debug doc hardened"

DEPEND="dev-db/firebird
	 dev-db/unixODBC"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	default
	cd "${S}/Builds/Gcc.lin/" || die "Could not change to build dir"
	mv makefile.linux Makefile || die "Could not mv/rename makefile"
	sed -i -e "s|#FIREBIRD=/usr/lib64/firebird|FIREBIRD=/usr|" \
		-e "s|-I/usr/include/odbc||" \
		-e 's|-I$(FBINCDIR)  $(INCLUDEDIR)|-I$(FBINCDIR)|' \
		-e 's|COMPFLAGS  = -w -D_REENTRANT -D_PTHREADS -DEXTERNAL -D$(ODBCMANAGER) $(INCLUDEDIR) -I$(FBINCDIR)|COMPFLAGS	= -w ${CXXFLAGS}|' \
		-e "s|COMPFLAGS   += -fPIC -m64|COMPFLAGS	+= -fPIC|" \
		-e "s|LINKFLAGS	= -shared -m64|LINKFLAGS	= -shared|" \
		-e "s|COMPFLAGS   += -m32||" \
		-e "s|LINKFLAGS	= -shared -m32|LINKFLAGS	= -shared|" \
		Makefile || die "Fixing Makefile via sed failed"

	sed -i -e 's|major"."minor"."buildnum|major "." minor "." buildnum|' \
		"${S}/SetupAttributes.h" \
		|| die "Could not sed borland version in SetupAttributes.h"

	# code needs to be fixed upstream, temp hack
	# "use hardened &&" fails for some reason thus if
	if use hardened; then
		sed -i -e "s|CXXFLAGS}|CXXFLAGS} -fpermissive|" \
		Makefile || die "Fixing Makefile via sed failed"
	fi
	append-flags -fPIC
}

src_compile() {
	cd "${S}/Builds/Gcc.lin/"
	emake -j1
}

src_install() {
	dolib.so Builds/Gcc.lin/Release_${ARCH}/libOdbcFb.so

	local odbcinst="${ROOT}/etc/unixODBC/odbcinst.ini"

	insinto /etc/unixODBC/
	if [ -e "${odbcinst}"} ]; then
		if [ -n $(grep libOdbcFb.so "${odbcinst}") ]; then
			cp "${odbcinst}" ./
			cat "${FILESDIR}"/${PN}.ini >> odbcinst.ini
			doins odbcinst.ini
		fi
	else
		newins "${FILESDIR}"/${PN}.ini odbcinst.ini
	fi

	if use doc; then
		dodoc Install/Linux/*.ini
		dodoc Install/Linux/*.txt
	fi
}
