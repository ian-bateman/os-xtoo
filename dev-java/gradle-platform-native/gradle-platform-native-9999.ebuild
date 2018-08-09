# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-diagnostics-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-platform-base-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-workers-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/gson:0
	dev-java/guava:26
	dev-java/javax-inject:0
	dev-java/jsr305:0
	dev-java/native-platform:0
	dev-java/slf4j-api:0
	dev-java/snakeyaml:0
"

inherit gradle

java_prepare() {
	sed -i -e "/Loader;/d" -e "s|new Loader(||" -e "s|)));|));|" \
		-e "/Dumper;/d" -e "s|JavaBeanDumper|Yaml|" \
		-e "s|JavaBeanDumper(false)|Yaml()|" \
		src/main/java/org/gradle/nativeplatform/toolchain/internal/swift/SwiftDepsHandler.java \
		|| die "Failed to sed/remove legacy snakeyaml"
}
