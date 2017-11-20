# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Virtual for Java Development Kit (JDK)"
KEYWORDS="~amd64"
SLOT="${PV%%.*}"

RDEPEND="|| (
		dev-java/openjdk-bin:${SLOT}
		dev-java/oracle-jdk-bin:${SLOT}
	)"
