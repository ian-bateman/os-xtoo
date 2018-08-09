# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN="gradle"
MY_PV="${PV/_/-}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

SLOT="0"

inherit java-pkg

DESCRIPTION="Gradle build automation system"
HOMEPAGE="https://gradle.org"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/"

GROOVY_SLOT="0"
MAVEN_SLOT="0"
PLEXUS_SLOT="0"
SLF4j_SLOT="0"

LIB_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/commons-collections:0
	dev-java/commons-compress:0
	dev-java/commons-httpclient:0
	dev-java/commons-io:0
	dev-java/commons-lang:2
	dev-java/commons-lang:3
	dev-java/fastutil:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-build-cache-${PV}:${SLOT}
	~dev-java/gradle-build-option-${PV}:${SLOT}
	~dev-java/gradle-cli-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-installation-beacon-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-launcher-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-model-groovy-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	~dev-java/gradle-tooling-api-${PV}:${SLOT}
	~dev-java/gradle-wrapper-${PV}:${SLOT}
	dev-java/groovy:${GROOVY_SLOT}
	dev-java/groovy-ant:${GROOVY_SLOT}
	dev-java/groovy-json:${GROOVY_SLOT}
	dev-java/groovy-templates:${GROOVY_SLOT}
	dev-java/groovy-xml:${GROOVY_SLOT}
	dev-java/guava:26
	dev-java/jansi:0
	dev-java/jansi-native:0
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/kryo:0
	dev-java/native-platform:0
	dev-java/slf4j-api:${SLF4j_SLOT}
	dev-java/slf4j-jul-to-slf4j:${SLF4j_SLOT}
"

PLUGINS_DEPEND="
	dev-java/ant-ivy:0
	dev-java/aqute-jpm-clnt:0
	dev-java/bndlib:4
	dev-java/bsh:0
	dev-java/commons-cli:1
	dev-java/commons-codec:0
	dev-java/eclipse-jgit:0
	~dev-java/gradle-announce-${PV}:${SLOT}
	~dev-java/gradle-antlr-${PV}:${SLOT}
	~dev-java/gradle-build-cache-http-${PV}:${SLOT}
	~dev-java/gradle-build-comparison-${PV}:${SLOT}
	~dev-java/gradle-build-init-${PV}:${SLOT}
	~dev-java/gradle-composite-builds-${PV}:${SLOT}
	~dev-java/gradle-dependency-management-${PV}:${SLOT}
	~dev-java/gradle-diagnostics-${PV}:${SLOT}
	~dev-java/gradle-ear-${PV}:${SLOT}
	~dev-java/gradle-ivy-${PV}:${SLOT}
	~dev-java/gradle-language-groovy-${PV}:${SLOT}
	~dev-java/gradle-language-java-${PV}:${SLOT}
	~dev-java/gradle-language-jvm-${PV}:${SLOT}
	~dev-java/gradle-osgi-${PV}:${SLOT}
	~dev-java/gradle-platform-base-${PV}:${SLOT}
	~dev-java/gradle-platform-jvm-${PV}:${SLOT}
	~dev-java/gradle-platform-native-${PV}:${SLOT}
	~dev-java/gradle-plugins-${PV}:${SLOT}
	~dev-java/gradle-plugin-use-${PV}:${SLOT}
	~dev-java/gradle-publish-${PV}:${SLOT}
	~dev-java/gradle-reporting-${PV}:${SLOT}
	~dev-java/gradle-resources-http-${PV}:${SLOT}
	~dev-java/gradle-testing-base-${PV}:${SLOT}
	~dev-java/gradle-testing-jvm-${PV}:${SLOT}
	~dev-java/gradle-test-kit-${PV}:${SLOT}
	~dev-java/gradle-tooling-api-builders-${PV}:${SLOT}
	~dev-java/gradle-version-control-${PV}:${SLOT}
	~dev-java/gradle-workers-${PV}:${SLOT}
	dev-java/gson:0
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:4.4
	dev-java/jcommander:0
	dev-java/joda-time:0
	dev-java/jsch:0
	dev-java/junit:4
	dev-java/maven-artifact:${MAVEN_SLOT}
	dev-java/maven-core:${MAVEN_SLOT}
	dev-java/maven-model:${MAVEN_SLOT}
	dev-java/maven-model-builder:${MAVEN_SLOT}
	dev-java/maven-plugin-api:${MAVEN_SLOT}
	dev-java/maven-repository-metadata:${MAVEN_SLOT}
	dev-java/maven-settings:${MAVEN_SLOT}
	dev-java/maven-settings-builder:${MAVEN_SLOT}
	dev-java/nekohtml:0
	dev-java/plexus-cipher:0
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:${PLEXUS_SLOT}
	dev-java/plexus-container-default:${PLEXUS_SLOT}
	dev-java/plexus-interpolation:0
	dev-java/plexus-sec-dispatcher:0
	dev-java/plexus-utils:0
	dev-java/testng:0
"

RDEPEND+="
	${LIB_DEPEND}
	${PLUGINS_DEPEND}
"

symlink_jars() {
	local dep deps jar jars

	dodir "${1}"
	deps="${2}"
	for dep in ${deps[@]}; do
		einfo "${dep}"
		dep="${dep/*dev-java\//}"
		dep="${dep/-${PV}/}"
		dep="${dep/:0/}"
		dep="${dep/:/-}"
		jars="$(jem -p ${dep})"
		jars="${jars//:/ }"
		for jar in ${jars[@]}; do
			dosym ${3}${jar} "${1}/${jar##*/}"
		done
	done
}

src_compile() {
:
}

src_install() {
	local dep dest jar jars

	dest="/usr/share/${PN}/"

	dobin "${FILESDIR}/${PN}"

	symlink_jars "${dest}lib" "${LIB_DEPEND[@]}" "../../../.."
	symlink_jars "${dest}lib/plugins" \
		"${PLUGINS_DEPEND[@]}" "../../../../.."

	insinto "${dest}"
	doins -r subprojects/distributions/src/toplevel/{init.d,media}
}
