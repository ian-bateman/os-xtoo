# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
MY_MOD="${PN##*-}"
BASE_URI="https://github.com/google/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/gson:0
	dev-java/guava:24
"

inherit java-pkg

DESCRIPTION="Protocol Buffers - ${MY_MOD}"
HOMEPAGE="https://developers.google.com/protocol-buffers/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" ~dev-libs/protobuf-${PV}"

S="${WORKDIR}/${MY_S}/java/${MY_MOD}"

java_prepare() {
	local f files

	files=(
		any api descriptor duration empty field_mask source_context
		struct timestamp type wrappers compiler/plugin
	)
	for f in ${files[@]}; do
		protoc --java_out=src/main/java --proto_path ../../src \
			../../src/google/protobuf/${f}.proto \
			|| die "Failed to generate ${f} java sources via protoc"
	done
}
