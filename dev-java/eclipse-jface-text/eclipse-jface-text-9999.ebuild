# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="eclipse.platform.text"
MY_PV="R${PV//./_}"
MY_PV="${MY_PV^^}"
MY_PV="${MY_PV/A/_a}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${PN:0:7}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	MY_S="${MY_P}"
fi

SLOT="${PV/.${PV#*.*.*}/}"

CP_DEPEND="
	~dev-java/eclipse-core-commands-${PV}:${SLOT}
	~dev-java/eclipse-core-jobs-${PV}:${SLOT}
	~dev-java/eclipse-core-runtime-${PV}:${SLOT}
	~dev-java/eclipse-equinox-common-${PV}:${SLOT}
	~dev-java/eclipse-jface-${PV}:${SLOT}
	~dev-java/eclipse-swt-${PV}:${SLOT}
	~dev-java/eclipse-text-${PV}:${SLOT}
	~dev-java/eclipse-osgi-${PV}:${SLOT}
	dev-java/osgi-core-api:7
	dev-java/icu4j:0
"

inherit java-pkg

DESCRIPTION="Eclipse JFace Text (org.eclipse.jface.text)"
HOMEPAGE="${BASE_URI}"
LICENSE="EPL-1.0"

S="${WORKDIR}/${MY_S}/org.${PN//-/.}/"

JAVA_SRC_DIR="projection src"

java_prepare() {
	# bad temporary hack to work around for the following!!!!
	# CodeMiningManager.java:185: error: incompatible types:
	# inferred type does not conform to lower bound(s)
	# return codeMinings.stream().collect(Collectors.groupingBy(ICodeMining::getPosition, LinkedHashMap::new,
	#
	# inferred: CAP#1
	# lower bound(s): ICodeMining
	# where CAP#1 is a fresh type-variable:
	# CAP#1 extends ICodeMining from capture of ? extends ICodeMining
	sed -i -e '185,186d' -e '187i\\t\treturn null;' \
		src/org/eclipse/jface/internal/text/codemining/CodeMiningManager.java \
		|| die "Failed to sed/remove troublesome code"
}
