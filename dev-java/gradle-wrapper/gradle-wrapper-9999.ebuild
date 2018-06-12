# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="gradle"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

CP_DEPEND="~dev-java/gradle-cli-${PV}:${SLOT}"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://gradle.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/subprojects/${PN#*-}"

java_prepare() {
	local my_pv

	mkdir src/main/resources || die "Failed to make resource dir"
	echo "
buildNumber=none
buildTimestamp=$(date +%Y%m%d%H%M%S)+0000
commitId=17d227d20f393004c3ae6bec5d5c925f92666c75
hostname=$(hostname)
isSnapshot=false
javaVersion=$(java --version | head -1 | cut -d ' ' -f 2)
osName=$(uname -o)
osVersion=$(uname -r)
project=gradle
rcNumber=
username=tcagent1
versionBase=${PV%*.*}
versionNumber=${PV}" \
		> src/main/resources/build-receipt.properties \
		|| die "Failed to generate build-receipt.properties"

	cp {"${FILESDIR}","${T}"}/gradle-wrapper.properties \
		|| die "Failed to copy wrapper for prep"

	my_pv="${MY_PV/.0-RC/-rc-}"
	[[ ${PV} == *.*.0 ]] && my_pv="${my_pv%*.0}"
	sed -i -e "s|PV|${my_pv}|" "${T}/gradle-wrapper.properties" \
		|| die "Failed to copy wrapper to sed/set version"
}

src_install() {
	java-pkg-simple_src_install

	insinto /usr/share/${PN}/lib
	doins "${T}/gradle-wrapper.properties"

	dobin "${FILESDIR}/gradlew"
}
