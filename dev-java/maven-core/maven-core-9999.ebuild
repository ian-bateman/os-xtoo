# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != 9999 ]]; then
	#SRC_URI="${BASE_URI}/archive/${MY_P}.tar.gz"
	SRC_URI="http://repo1.maven.org/maven2/org/apache/${MY_PN}/${PN}/${PV}/${P}-sources.jar"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-${MY_P}"
fi

SLOT="0"

AETHER_SLOT="0"
PC_SLOT="0"

CP_DEPEND="
	dev-java/aether-api:${AETHER_SLOT}
	dev-java/aether-impl:${AETHER_SLOT}
	dev-java/aether-spi:${AETHER_SLOT}
	dev-java/aether-util:${AETHER_SLOT}
	dev-java/commons-lang:3
	dev-java/javax-inject:0
	dev-java/guice:4
	~dev-java/maven-artifact-${PV}:${SLOT}
	~dev-java/maven-builder-support-${PV}:${SLOT}
	~dev-java/maven-model-${PV}:${SLOT}
	~dev-java/maven-model-builder-${PV}:${SLOT}
	~dev-java/maven-plugin-api-${PV}:${SLOT}
	~dev-java/maven-repository-metadata-${PV}:${SLOT}
	~dev-java/maven-resolver-provider-${PV}:${SLOT}
	~dev-java/maven-settings-${PV}:${SLOT}
	~dev-java/maven-settings-builder-${PV}:${SLOT}
	dev-java/maven-shared-utils:0
	dev-java/plexus-classworlds:0
	dev-java/plexus-component-annotations:${PC_SLOT}
	dev-java/plexus-container-default:${PC_SLOT}
	dev-java/plexus-sec-dispatcher:0
	dev-java/plexus-utils:0
	dev-java/sisu-inject:0
"

inherit java-pkg

DESCRIPTION="${PN//-/ }"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

DEPEND+=" dev-java/modello-plugin-java:0"

#S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
#	local f

	# set version etc
#	sed -i -e "s|\${buildNumber}|0|" \
#		-e "s|\${timestamp}|$(date +%s)|" \
#		-e "s|\${project.version}|${PV}|" \
#		-e "s|\${distributionId}|apache-maven|" \
#		-e "s|\${distributionShortName}|Maven|" \
#		-e "s|\${distributionName}|Apache Maven|" \
#		src/main/resources/org/apache/maven/messages/build.properties \
#		|| die "Failed to sed version and other"

#	for f in extension toolchains; do
#		modello "src/main/mdo/${f}.mdo" java src/main/java \
#			4.0.0 false true \
#			|| die "Failed to generate .java files via modello cli"
#	done

	sed -i -e '436d' -e "s|, new SessionScopeModule( container ),|);|" \
		-e "s/ComponentLookupException |/PlexusConfigurationException |/" \
		org/apache/maven/plugin/internal/DefaultMavenPluginManager.java \
		|| die "Failed to sed/fix argument list"
}
