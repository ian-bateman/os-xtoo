# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"
AETHER_SLOT="0"
GROOVY_SLOT="0"
MAVEN_SLOT="0"

CP_DEPEND="
	dev-java/aether-api:${AETHER_SLOT}
	dev-java/aether-util:${AETHER_SLOT}
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-plugins-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	~dev-java/gradle-wrapper-${PV}:${SLOT}
	dev-java/groovy:${GROOVY_SLOT}
	dev-java/groovy-templates:${GROOVY_SLOT}
	dev-java/guava:26
	dev-java/javax-inject:0
	dev-java/jsr305:0
	dev-java/maven-artifact:${MAVEN_SLOT}
	dev-java/maven-core:${MAVEN_SLOT}
	dev-java/maven-model:${MAVEN_SLOT}
	dev-java/maven-model-builder:${MAVEN_SLOT}
	dev-java/maven-settings:${MAVEN_SLOT}
	dev-java/plexus-classworlds:0
	dev-java/plexus-container-default:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e "s|sonatype|eclipse|g" -e "s|aether.util|aether|" \
		src/main/java/org/gradle/buildinit/plugins/internal/maven/MavenProjectsCreator.java \
		|| die "Failed to sed/swap sonatype imports with eclipse"
}
