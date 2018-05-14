# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-pkg

DESCRIPTION="JSR 250 Common Annotations"
HOMEPAGE="https://jcp.org/en/jsr/detail?id=250"
SRC_URI="https://repo1.maven.org/maven2/javax/annotation/javax.annotation-api/${PV}/javax.annotation-api-${PV}-sources.jar"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/unzip"
