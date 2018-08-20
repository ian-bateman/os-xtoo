# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/easymock/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

inherit java-pkg

DESCRIPTION="Library to bypass the constructor when creating an object"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

S="${WORKDIR}/${P}/main"

JAVAC_ARGS+=" --add-exports=java.base/jdk.internal.misc=ALL-UNNAMED "

java_prepare() {
	local f

	for f in $(grep -l -m1 misc.Unsafe -r *); do
		sed -i -e "s|sun.misc|jdk.internal.misc|g" "${f}" \
			|| die "Failed to sed/fix Unsafe import"
	done
}
