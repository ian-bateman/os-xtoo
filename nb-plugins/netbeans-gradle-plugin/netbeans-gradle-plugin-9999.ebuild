# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

MY_PN="netbeans-gradle-project"
MY_P="${MY_PN}-${PV}"
BASE_URI="https://github.com/kelemen/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

DESCRIPTION="NetBeans plugin able to open Gradle based Java projects"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

GRADLE_SLOT="0"
JTRIM_SLOT="0"
NB_SLOT="9"

CP_DEPEND="
	dev-java/jsr305:0
	dev-java/gradle-base-services:${GRADLE_SLOT}
	dev-java/gradle-tooling-api:${GRADLE_SLOT}
	dev-java/guava:25
	dev-java/javax-annotation:0
	dev-java/jtrim-collections:${JTRIM_SLOT}
	dev-java/jtrim-concurrent:${JTRIM_SLOT}
	dev-java/jtrim-executor:${JTRIM_SLOT}
	dev-java/jtrim-property:${JTRIM_SLOT}
	dev-java/jtrim-swing-concurrent:${JTRIM_SLOT}
	dev-java/jtrim-swing-property:${JTRIM_SLOT}
	dev-java/jtrim-utils:${JTRIM_SLOT}
	nb-ide/netbeans-api-annotations-common:${NB_SLOT}
	nb-ide/netbeans-api-debugger:${NB_SLOT}
	nb-ide/netbeans-api-debugger-jpda:${NB_SLOT}
	nb-ide/netbeans-api-java:${NB_SLOT}
	nb-ide/netbeans-api-java-classpath:${NB_SLOT}
	nb-ide/netbeans-api-progress:${NB_SLOT}
	nb-ide/netbeans-api-progress-nb:${NB_SLOT}
	nb-ide/netbeans-api-templates:${NB_SLOT}
	nb-ide/netbeans-core-multitabs:${NB_SLOT}
	nb-ide/netbeans-core-multiview:${NB_SLOT}
	nb-ide/netbeans-editor-indent-project:${NB_SLOT}
	nb-ide/netbeans-editor-lib2:${NB_SLOT}
	nb-ide/netbeans-editor-mimelookup:${NB_SLOT}
	nb-ide/netbeans-gsf-codecoverage:${NB_SLOT}
	nb-ide/netbeans-gsf-testrunner:${NB_SLOT}
	nb-ide/netbeans-gsf-testrunner-ui:${NB_SLOT}
	nb-ide/netbeans-java-api-common:${NB_SLOT}
	nb-ide/netbeans-java-platform:${NB_SLOT}
	nb-ide/netbeans-java-project:${NB_SLOT}
	nb-ide/netbeans-java-project-ui:${NB_SLOT}
	nb-ide/netbeans-java-source-base:${NB_SLOT}
	nb-ide/netbeans-o-n-swing-tabcontrol:${NB_SLOT}
	nb-ide/netbeans-openide-awt:${NB_SLOT}
	nb-ide/netbeans-openide-dialogs:${NB_SLOT}
	nb-ide/netbeans-openide-filesystems:${NB_SLOT}
	nb-ide/netbeans-openide-filesystems-nb:${NB_SLOT}
	nb-ide/netbeans-openide-io:${NB_SLOT}
	nb-ide/netbeans-openide-loaders:${NB_SLOT}
	nb-ide/netbeans-openide-modules:${NB_SLOT}
	nb-ide/netbeans-openide-nodes:${NB_SLOT}
	nb-ide/netbeans-openide-text:${NB_SLOT}
	nb-ide/netbeans-openide-util:${NB_SLOT}
	nb-ide/netbeans-openide-util-lookup:${NB_SLOT}
	nb-ide/netbeans-openide-util-ui:${NB_SLOT}
	nb-ide/netbeans-openide-windows:${NB_SLOT}
	nb-ide/netbeans-options-api:${NB_SLOT}
	nb-ide/netbeans-parsing-api:${NB_SLOT}
	nb-ide/netbeans-projectapi:${NB_SLOT}
	nb-ide/netbeans-projectuiapi:${NB_SLOT}
	nb-ide/netbeans-projectuiapi-base:${NB_SLOT}
	nb-ide/netbeans-queries:${NB_SLOT}
	~nb-plugins/netbeans-gradle-default-models-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/${PN}"

JAVA_RM_FILES=( src/main/java/org/netbeans/gradle/project/groovy )

src_unpack() {
	default
}

src_prepare() {
	mkdir src/main/resources/META-INF || die "Failed to create META-INF dir"
	cp "${FILESDIR}/MANIFEST.MF" src/main/resources/META-INF \
		|| die "Failed to copy MANIFEST.MF"

	sed -i -e "s|PV|${PV}|" -e "s|DATE|$(date +%Y%m%d%k%M)|" \
		src/main/resources/META-INF/MANIFEST.MF \
		|| die "Failed to sed PV/DATE in MANIFEST.MF"

	java-netbeans_src_prepare
}
