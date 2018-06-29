# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV/201/v201}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/eclipse/${MY_PN}-core"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-core-${MY_P}"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/aether-api-${PV}:${SLOT}
	~dev-java/aether-spi-${PV}:${SLOT}
	~dev-java/aether-util-${PV}:${SLOT}
	dev-java/guice:4
	dev-java/javax-inject:0
	dev-java/osgi-core-api:7
	dev-java/slf4j-api:0
	dev-java/sisu-inject:0
"

inherit java-pkg

DESCRIPTION="An implementation of the repository system."
HOMEPAGE="https://www.eclipse.org/aether/"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	sed -i -e "s|class Simple|public class Simple|" \
		src/main/java/org/eclipse/aether/internal/impl/SimpleLocalRepositoryManager.java \
		|| die "Failed to sed/fix access modifier"
}
