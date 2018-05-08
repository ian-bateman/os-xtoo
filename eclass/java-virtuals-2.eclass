# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-virtuals-2.eclass
# @MAINTAINER:
# William L. Thomson Jr. <wlt@o-sinc.com>
# @AUTHOR:
# William L. Thomson Jr. <wlt@o-sinc.com>
# Original Author: Alistair John Bush <ali_bush@gentoo.org>
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @BLURB: Java virtuals eclass
# @DESCRIPTION:
# To provide a default (and only) src_install function for ebuilds in the
# java-virtuals category.

inherit java-utils-2

DEPEND="dev-java/jem"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

EXPORT_FUNCTIONS src_install

# @FUNCTION: java-virtuals-2_src_install
# @DESCRIPTION:
# default src_install
java-virtuals-2_src_install() {
	java-virtuals-2_do_write
}

# @FUNCTION: java-pkg_do_virtuals_write
# @INTERNAL
# @DESCRIPTION:
# Writes the virtual env file out to disk.
java-virtuals-2_do_write() {
	debug-print-function ${FUNCNAME} "$*"
	java-pkg_init_paths_

	local p

	p="/etc/jem/virtuals.d"
	dodir "${p}"
	{
		[[ -n "${JAVA_VIRTUAL_PROVIDES}" ]] && \
			echo "PROVIDERS=\"${JAVA_VIRTUAL_PROVIDES}\""

		[[ -n "${JAVA_VIRTUAL_VM}" ]] && \
			echo "VM=\"${JAVA_VIRTUAL_VM}\""

		[[ -n "${JAVA_VIRTUAL_VM_CLASSPATH}" ]] && \
			echo "VM_CLASSPATH=\"${JAVA_VIRTUAL_VM_CLASSPATH}\""

	} > "${D}${p}/${JAVA_PKG_NAME}"
}
