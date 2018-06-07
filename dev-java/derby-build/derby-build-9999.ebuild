# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:5}"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
fi

SLOT="0"

CP_DEPEND="
	~dev-java/derby-engine-${PV}:${SLOT}
	~dev-java/derby-shared-${PV}:${SLOT}
	dev-java/ant-core:0
"

inherit java-pkg

DESCRIPTION="Relational database implemented entirely in Java - ${PN:6}"
HOMEPAGE="https://db.apache.org/${PN}/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_P}/java/${PN:6}"
# File moved to derby-engine
JAVA_RM_FILES=( org/apache/derbyPreBuild/ReleaseProperties.java )

java_prepare() {
	local f

	for f in DiskLayout EndFormat FormatId Purpose Upgrade; do
		sed -i -e "s|com.sun.tools.doclets|jdk.javadoc.doclet|" \
			-e '/Taglet;/iimport java.util.List;\nimport java.util.Set;\nimport javax.lang.model.element.Element;\nimport com.sun.source.doctree.DocTree;' \
			-e '/^}/i\\ \ \ \public String toString(List<? extends DocTree> tags, Element element) { return new String(); }\n\ \ \ \  public Set<Location> getAllowedLocations() { return null; }' \
			org/apache/derbyBuild/javadoc/${f}Taglet.java \
			|| die "Failed to sed/fix class package change"
	done
}
