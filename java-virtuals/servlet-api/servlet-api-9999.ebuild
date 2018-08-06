# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet-api"
HOMEPAGE="https://en.wikipedia.org/wiki/Java_servlet#History"
SRC_URI=""
LICENSE="public-domain"

if [[ ${PV} == *9999* ]]; then
	SLOT="4.0"
	KEYWORDS="-amd64"
else
	SLOT="${PV}"
	KEYWORDS="~amd64"
fi

RDEPEND="dev-java/tomcat-servlet-api:${SLOT}"

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT}"
