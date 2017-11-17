# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-virtuals-2

DESCRIPTION="Virtual ebuilds that require internal com.sun classes from a JDK"
HOMEPAGE="https://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/oracle-jdk-bin:9
			dev-java/oracle-jdk-bin:1.8
			dev-java/icedtea-bin:8
			dev-java/icedtea:8
		)"

JAVA_VIRTUAL_VM="icedtea-bin-8 icedtea-8 oracle-jdk-bin-1.8 oracle-jdk-bin-9"
