# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

BASE_URI="https://github.com/bulenkov/${PN}"

if [[ ${PV} != *9999* ]]; then
	MY_SNAP="d993b829d8b37c23fdbc492afc784ac3d4e41410"
	SRC_URI="${BASE_URI}/archive/${MY_SNAP}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_SNAP}"
fi

CP_DEPEND="dev-java/intellij-platform-annotations:0"

inherit java-pkg

DESCRIPTION="Smart Java Icon Loader with support of HiDPI (Retina) images"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-exports java.base/jdk.internal.reflect=ALL-UNNAMED "
JAVA_RM_FILES=(
	src/com/bulenkov/iconloader/AppleHiDPIScaledImage.java
	src/com/bulenkov/iconloader/IsRetina.java
	src/com/bulenkov/iconloader/RetinaImage.java
)

java_prepare() {
	sed -i -e '297d;486d;' \
		src/com/bulenkov/iconloader/IconLoader.java \
		|| die "Failed to remove usage of apple classes"

	sed -i -e "s|sun.r|jdk.internal.r|" \
		src/com/bulenkov/iconloader/util/StringFactory.java \
		|| die "Failed to sed/fix java9+ changed import"

	sed -i -e '20d;204,206d;263d;' -e 's|loadRetinaImages|false|' \
		src/com/bulenkov/iconloader/util/ImageLoader.java \
		|| die "Failed to remove usage of apple classes"

	sed -i -e "/IsRetina/d" -e "/RetinaImage/d" \
		src/com/bulenkov/iconloader/util/UIUtil.java \
		|| die "Failed to remove usage of apple classes"
}
