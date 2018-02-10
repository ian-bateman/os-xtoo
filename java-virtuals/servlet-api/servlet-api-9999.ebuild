# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet-api"
HOMEPAGE="https://en.wikipedia.org/wiki/Java_servlet#History"
SRC_URI=""
LICENSE="public-domain"
KEYWORDS="~amd64"

if [[ ${PV} == *9999* ]]; then
	SLOT="4.0"
else
	SLOT="${PV}"
fi

RDEPEND="dev-java/tomcat-servlet-api:${SLOT}"

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT}"
