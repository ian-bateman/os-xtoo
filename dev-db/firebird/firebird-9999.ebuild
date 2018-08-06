# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

if [[ ${PV} == *_* ]]; then
	MY_PN="T"
else
	MY_PN="R"
fi
MY_PV="${PV/_a/_A}"
MY_PV="${MY_PV//./_}"
MY_P="${MY_PN}${MY_PV}"
BASE_URI="https://github.com/FirebirdSQL/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
	MY_S="${P}"
else
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

inherit autotools eutils flag-o-matic multilib readme.gentoo-r1 user ${ECLASS}

DESCRIPTION="A relational database offering many ANSI SQL:2003 and some SQL:2008 features"
HOMEPAGE="https://www.firebirdsql.org/"
LICENSE="IDPL Interbase-1.0"
SLOT="0"

IUSE="client debug examples xinetd"
REQUIRED_USE="client? ( !xinetd )"

CDEPEND="
	dev-libs/libedit
	dev-libs/libtommath
	dev-libs/icu:=
"
DEPEND="${CDEPEND}
	>=dev-util/btyacc-3.0-r2
"
RDEPEND="${CDEPEND}
	xinetd? ( virtual/inetd )
	!sys-cluster/ganglia
"

RESTRICT="userpriv"

S="${WORKDIR}/${MY_S}"

pkg_setup() {
	enewgroup ${PN} 450
	enewuser ${PN} 450 /bin/sh /usr/$(get_libdir)/${PN} ${PN}
}

check_sed() {
	MSG="sed of $3, required $2 lines modified $1"
	einfo "${MSG}"
	[[ $1 -ge $2 ]] || die "${MSG}"
}

src_prepare() {
	default
	# sed vs patch for portability and addtional location changes
# Fails with btyacc in tree
#	sed -i -e 's|$(ROOT)/extern/btyacc|/usr/bin|' \
#		builds/posix/make.defaults \
#		|| die "Failed to sed make.defaults"

# Need to build cloop
#	sed -i -e 's|external:|external: ;|' -e '134d' \
#		builds/posix/Makefile.in \
#		|| die "Failed to sed Makefile.in"

	# Rename references to isql to fbsql
	check_sed "$(sed -i -e 's:"isql :"fbsql :w /dev/stdout' \
		src/isql/isql.epp | wc -l)" "1" "src/isql/isql.epp" # 1 line
	check_sed "$(sed -i -e 's:isql :fbsql :w /dev/stdout' \
		src/msgs/history2.sql | wc -l)" "4" "src/msgs/history2.sql" # 4 lines
	check_sed "$(sed -i -e 's:--- ISQL:--- FBSQL:w /dev/stdout' \
		-e 's:isql :fbsql :w /dev/stdout' \
		-e 's:ISQL :FBSQL :w /dev/stdout' \
		src/msgs/messages2.sql | wc -l)" "6" "src/msgs/messages2.sql" # 6 lines

	# doing for all archs not just keyworded
	sed -i -e 's|-ggdb ||g' \
		-e 's|-pipe ||g' \
		-e 's|$(COMMON_FLAGS) $(OPTIMIZE_FLAGS)|$(COMMON_FLAGS)|g' \
		builds/posix/prefix.linux* || die

	sed -i -e "s|\$(this)|/usr/$(get_libdir)/firebird/intl|g" \
		builds/install/misc/fbintl.conf || die

	sed -i -e "s|\$(this)|/usr/$(get_libdir)/firebird/plugins|g" \
		src/plugins/udr_engine/udr_engine.conf || die

	find . -name \*.sh -print0 | xargs -0 chmod +x \
		|| die "Failed to change permissions on scripts"

	# Need btyacc, cloop, and decNumber
	rm -r extern/{SfIO,editline,icu,libtommath,zlib} \
		|| die "Failed to remove bundled projects"

	eautoreconf
}

src_configure() {
	local d

	filter-flags -fprefetch-loop-arrays
	replace-flags -fomit-frame-pointer -fno-omit-frame-pointer
	append-flags -fpermissive

	d="/usr/$(get_libdir)/${PN}"
	econf \
		--prefix=${d} \
		--with-editline \
		--with-system-editline \
		--with-fbbin=/usr/bin \
		--with-fbsbin=/usr/sbin \
		--with-fbconf=/etc/${PN} \
		--with-fblib=/usr/$(get_libdir) \
		--with-fbinclude=/usr/include \
		--with-fbdoc=/usr/share/doc/${P} \
		--with-fbudf=${d}/UDF \
		--with-fbsample=/usr/share/doc/${P}/examples \
		--with-fbsample-db=/usr/share/doc/${P}/examples/db \
		--with-fbhelp=${d}/help \
		--with-fbintl=${d}/intl \
		--with-fbmisc=/usr/share/${PN} \
		--with-fbsecure-db=/etc/${PN} \
		--with-fbmsg=${d} \
		--with-fblog=/var/log/${PN}/ \
		--with-fbglock=/var/run/${PN} \
		--with-fbplugins=${d}/plugins \
		--with-gnu-ld \
		${myconf}
}

src_install() {
	local b bins d lib p plugins

	lib="/usr/$(get_libdir)"
	d="${lib}/${PN}"
	cd "${S}"/gen/Release/${PN} || die

	doheader include/*

	insinto ${lib}
	dolib.so lib/*.so*

	# links for backwards compatibility
	dosym libfbclient.so ${lib}/libgds.so
	dosym libfbclient.so ${lib}/libgds.so.0
	dosym libfbclient.so ${lib}/libfbclient.so.1

	insinto ${d}
	doins *.msg

	use client && return

	mv bin/{i,fb}sql || die

	bins=( fbsql fbsvcmgr fbtracemgr gbak gfix gpre gsec gsplit gstat
		nbackup qli
	)
	for b in ${bins[@]}; do
		dobin bin/${b}
	done

	for b in fbguard fb_lock_print firebird; do
		dosbin bin/${b}
	done

	exeinto /usr/bin/${PN}
	exeopts -m0755
	doexe bin/{changeServerMode,registerDatabase}.sh

	insinto ${d}/help
	doins help/help.fdb

	exeinto ${d}/intl
	dolib.so intl/libfbintl.so
	dosym ../../libfbintl.so ${d}/intl/libfbintl.so
	dosym ../../../../etc/${PN}/fbintl.conf \
		${d}/intl/fbintl.conf

	exeinto ${d}/plugins
	plugins=(
		Engine13 fbtrace Legacy_Auth Legacy_UserManager Srp udr_engine
	)
	for p in ${plugins[@]}; do
		p="lib${p}.so"
		dolib.so plugins/${p}
		dosym "${D}"/usr/$(get_libdir)/${p} ${d}/plugins/${p}
	done
	dodir ${d}/udr
	dosym "${D}"/etc/${PN}/udr_engine.conf ${d}/plugins/udr_engine.conf

	exeinto ${d}/UDF
	doexe UDF/*.so

	insinto /usr/share/${PN}/upgrade
	doins -r "${S}"/src/misc/upgrade/*

	insinto /etc/${PN}
	insopts -m0644 -o firebird -g firebird
	doins *.conf
	doins intl/fbintl.conf
	doins plugins/udr_engine.conf
	insopts -m0660 -o firebird -g firebird
	doins security${PV%%.*}.fdb

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/${PN}.xinetd" ${PN}
	else
		newinitd "${FILESDIR}/${PN}.init.d" ${PN}
		newconfd "${FILESDIR}/${PN}.conf.d" ${PN}
		fperms 640 /etc/conf.d/${PN}
	fi

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" ${PN}
	fowners root:root /etc/logrotate.d/${PN}
	fperms 0644 /etc/logrotate.d/${PN}

	diropts -m 755 -o firebird -g firebird
	keepdir /var/log/${PN}
	keepdir /var/run/${PN}

	if use examples; then
		docinto examples
		insinto /usr/share/${PN}/examples
		insopts -m0660 -o firebird -g firebird
		doins -r "${S}"/examples/* "${S}"/gen/examples/employee.fdb
	fi
}

pkg_config() {
	use client && return
	local d

	d="${ROOT}/etc/${PN}"
	# if found /etc/security4.gdb from previous install, backup, and restore as
	# /etc/security4.fdb
	if [[ -f "${d}/security3.gdb" ]] ; then
		# if we have scurity2.fdb already, back it 1st
		if [[ -f "${d}/security4.fdb" ]] ; then
			cp "${d}/security4.fdb" "${d}/security4.fdb.old" || die
		fi
		gbak -B "${d}/security3.gdb" "${d}/security3.gbk" || die
		gbak -R "${d}/security3.gbk" "${d}/security4.fdb" || die
		mv "${d}/security3.gdb" "${d}/security3.gdb.old" || die
		rm "${d}/security3.gbk" || die

		# make sure they are readable only to firebird
		chown ${PN}:${PN} "${d}/{security3.*,security4.*}" || die
		chmod 660 "${d}/{security3.*,security4.*}" || die

		echo
		einfo "Converted old security3.gdb to security4.fdb, security3.gdb has been "
		einfo "renamed to security3.gdb.old. if you had previous security4.fdb, "
		einfo "it's backed to security4.fdb.old (all under ${d})."
		echo
	fi

	# we need to enable local access to the server
	if [[ ! -f "${ROOT}/etc/hosts.equiv" ]] ; then
		touch "${ROOT}/etc/hosts.equiv" || die
		chown root:0 "${ROOT}/etc/hosts.equiv" || die
		chmod u=rw,go=r "${ROOT}/etc/hosts.equiv" || die
	fi

	# add 'localhost.localdomain' to the hosts.equiv file...
	if grep -q 'localhost.localdomain$' "${ROOT}/etc/hosts.equiv" ; then
		echo "localhost.localdomain" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost.localdomain to ${ROOT}/etc/hosts.equiv"
	fi

	# add 'localhost' to the hosts.equiv file...
	if grep -q 'localhost$' "${ROOT}/etc/hosts.equiv" ; then
		echo "localhost" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added localhost to ${ROOT}/etc/hosts.equiv"
	fi

	HS_NAME=`hostname`
	if grep -q ${HS_NAME} "${ROOT}/etc/hosts.equiv" ; then
		echo "${HS_NAME}" >> "${ROOT}/etc/hosts.equiv"
		einfo "Added ${HS_NAME} to ${ROOT}/etc/hosts.equiv"
	fi

	einfo "If you're using UDFs, please remember to move them"
	einfo "to /usr/lib/firebird/UDF"
}
