# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/eclipse-ee4j/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${P}"
fi

CP_DEPEND="dev-java/javax-activation:0"

inherit java-pkg

DESCRIPTION="JavaMail API Reference Implementation"
HOMEPAGE="https://javaee.github.io/javamail/"
LICENSE="EPL-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/mail"

JAVA_SRC_DIR="
	src/main/java
	src/main/resources
"
