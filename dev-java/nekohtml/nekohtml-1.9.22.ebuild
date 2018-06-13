# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

CP_DEPEND="dev-java/xerces:2"

inherit java-pkg

DESCRIPTION="HTML scanner and tag balancer"
HOMEPAGE="https://sourceforge.net/projects/nekohtml"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="https://repo1.maven.org/maven2/net/sourceforge/${PN}/${PN}/${PV}/${P}-sources.jar"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

#S="${WORKDIR}/${P}"

DEPEND+=" app-arch/unzip"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="org"
JAVA_RES_DIR="resources"

java_prepare() {
	local f

	mkdir resources || die "Failed to make resources directory"
	mv META-INF resources || die "Failed to move resources to subdir"

	for f in 0 1; do
		sed -i -e "s|encoding, augs|encoding, nscontext, augs|" \
			org/cyberneko/html/xercesbridge/XercesBridge_2_${f}.java \
			|| die "Failed to sed/fix arguments"
	done

	sed -i -e '/impl.Version;/aimport org.apache.xerces.impl.xs.opti.DefaultXMLDocumentHandler;' \
		-e "s|XMLDocumentHandler documentHandler, String|DefaultXMLDocumentHandler documentHandler, String|g" \
		org/cyberneko/html/xercesbridge/XercesBridge_2_0.java \
		|| die "Failed to sed/fix xerces api changes"
}
