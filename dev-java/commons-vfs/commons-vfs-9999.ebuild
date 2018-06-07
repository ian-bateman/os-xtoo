# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"
JAVA_NO_COMMONS=1

SLOT="${PV%%.*}"
MY_PN="${PN}${SLOT}-project"
MY_P="${MY_PN}-${PV}"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${MY_P}"
fi

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-collections:4
	dev-java/commons-compress:0
	dev-java/commons-httpclient:0
	dev-java/commons-logging:0
	dev-java/commons-net:0
	dev-java/jackrabbit-webdav:0
	dev-java/jsch:0
"

inherit java-pkg

DESCRIPTION="A single API for accessing various different file systems"
HOMEPAGE="https://commons.apache.org/proper/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN}${SLOT}"

PATCHES=( "${FILESDIR}/jackrabbit.patch" )

# Need to package
#	org.apache.hadoop.conf.Configuration
#	org.apache.hadoop.fs.*
JAVA_RM_FILES=( src/main/java/org/apache/commons/vfs2/provider/hdfs )
