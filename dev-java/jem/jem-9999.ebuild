# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

BASE_URI="https://github.com/Obsidian-StudiosInc/${PN}"

if [[ ${PV} == 9999 ]]; then
	ECLASS="git-r3"
	EGIT_REPO_URI="${BASE_URI}.git"
else
	KEYWORDS="~amd64"
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

CMAKE_MAKEFILE_GENERATOR="ninja"

inherit cmake-utils ${ECLASS}

MY_P="${P}-Source"

DESCRIPTION="A java environment manager"
HOMEPAGE="https://www.o-sinc.com/#!/software/${PN}"
LICENSE="GPL-3"
SLOT="0"
IUSE="debug doc elibc_glibc source test"

DEPEND="debug? (
		dev-util/valgrind
		!prefix? ( elibc_glibc? ( sys-libs/glibc[debug] ) )
	)
	doc? ( app-doc/doxygen )
"
RDEPEND="
	>=app-eselect/eselect-java-1
	!dev-java/java-config
"

src_prepare() {
	default

	cp "${FILESDIR}"/java-vm.eselect "${S}" \
		|| die "Failed to copy eselect module"
	sed -i -e "s|VERSION=\".*\"|VERSION=\"${PV}\"|" "${S}/java-vm.eselect" \
		|| die "Failed to sed eselect module version"
}

src_configure() {
	local mytype="Release"
	use debug && mytype="Debug"
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=${mytype}
		-DCMAKE_DOC=$(usex doc)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# not sure what is going on here
	fperms 755 /usr/bin/run-java-tool.bash

	dodir /etc/jem/{build,virtuals.d,vms.d}

	echo 'CONFIG_PROTECT_MASK="/etc/jem/vms.d /etc/jem/virtuals.d"' \
		> 20jem || die "Failed to create env.d file"
	doenvd 20jem

	insinto /usr/share/eselect/modules/
	doins "${S}"/java-vm.eselect

	local jc_files=( build/compilers.conf build/jdk.conf virtuals )
	for file in "${jc_files[@]}"; do
		if [[ ! -f "${ED}"/etc/jem/${file/ls/ls.conf} ]] ; then
			cp "${FILESDIR}"/${file/build\//} \
				"${ED}"/etc/jem/${file/ls/ls.conf} || die
		fi
	done

	if use source ; then
		mkdir "${ED}"/usr/share/${PN}/sources \
			|| die "Failed to mkdir for sources"
		cp -R "${S}"/{include,src} "${ED}"/usr/share/${PN}/sources \
			|| die "Failed to copy sources"
	fi
}
