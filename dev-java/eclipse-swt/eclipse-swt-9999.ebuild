# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.platform.swt"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Eclipse SWT (org.eclipse.swt)"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"
SLOT="${PV/.${PV#*.*.*}/}"

DEPEND=">=virtual/jdk-1.8"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${MY_S}/bundles/org.${PN//-/.}/"

JAVA_SRC_DIR="
	Eclipse_SWT_AWT/gtk/org
	Eclipse_SWT_Accessibility/common/org
	Eclipse_SWT_Accessibility/gtk/org
	Eclipse_SWT_Browser/common/org
	Eclipse_SWT_Browser/gtk/org
	Eclipse_SWT_Custom_Widgets/common/org
	Eclipse_SWT_Drag_and_Drop/common/org
	Eclipse_SWT_Drag_and_Drop/gtk/org
	Eclipse_SWT_Mozilla/common/org
	Eclipse_SWT_Mozilla/gtk/org
	Eclipse_SWT_OpenGL/common/org
	Eclipse_SWT_OpenGL/glx/org
	Eclipse_SWT_OpenGL/gtk/org
	Eclipse_SWT_PI/cairo/org
	Eclipse_SWT_PI/common/org
	Eclipse_SWT_PI/common_j2se/org
	Eclipse_SWT_PI/gtk/org
	Eclipse_SWT_Printing/common/org
	Eclipse_SWT_Printing/gtk/org
	Eclipse_SWT_Program/cde/org
	Eclipse_SWT_Program/common/org
	Eclipse_SWT_Program/gnome/org
	Eclipse_SWT_Program/gtk/org
	Eclipse_SWT_WebKit/gtk/org
	Eclipse_SWT/cairo/org
	Eclipse_SWT/common/org
	Eclipse_SWT/common_j2se/org
	Eclipse_SWT/emulated/bidi
	Eclipse_SWT/emulated/coolbar
	Eclipse_SWT/emulated/taskbar
	Eclipse_SWT/gtk/org
"
# Has duplicate classes from gtk limit to required bidi/coolbar/taskbar
#	Eclipse_SWT/emulated

java_prepare() {
	# Replace spaces in dir names with underscore
	local d
	for d in *; do
		if [[ -d "${d}" ]] && [[ "${d}" =~ \ |\' ]]; then
			mv "${d}" "${d// /_}"
		fi
	done
}
