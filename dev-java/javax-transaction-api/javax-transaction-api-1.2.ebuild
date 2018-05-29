# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

CP_DEPEND="
	dev-java/cdi-api:0
	dev-java/javax-interceptor-api:0
"

inherit java-pkg

DESCRIPTION="Java Transaction API"
HOMEPAGE="https://github.com/javaee/jta-spec"
SRC_URI="https://repo1.maven.org/maven2/${PN:0:5}/${PN:6:11}/${MY_PN}/${PV}/${MY_P}-sources.jar"
LICENSE="CDDL GPL-2-with-classpath-exception"
KEYWORDS="~amd64"
SLOT="0"

DEPEND+=" app-arch/unzip"

JAVA_RM_FILES=( javax/transaction/xa )
