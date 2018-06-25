# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

# No releases and has mdo... :(
# https://github.com/codehaus-plexus/plexus-sec-dispatcher/issues/3
BASE_URI="https://github.com/codehaus-plexus/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://repo1.maven.org/maven2/org/sonatype/plexus/${PN}/${PV}/${P}-sources.jar"
	#SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${P}"
fi

CP_DEPEND="
	dev-java/plexus-cipher:0
	dev-java/plexus-container-default:0
	dev-java/plexus-utils:0
"

inherit java-pkg

DESCRIPTION="Plexus Security Dispatcher Component"
HOMEPAGE="http://codehaus-plexus.github.io/${PN}/"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND+=" dev-java/modello-plugin-java:0"

#S="${WORKDIR}/${MY_S}/"

#java_prepare() {
#	modello "src/main/mdo/settings-security.mdo" java src/main/java \
#		4.0.0 false true \
#		|| die "Failed to generate .java files via modello cli"
#}
