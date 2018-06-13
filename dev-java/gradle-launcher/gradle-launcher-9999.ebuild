# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/commons-io:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-build-option-${PV}:${SLOT}
	~dev-java/gradle-cli-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-tooling-api-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:25
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	echo "Manifest-Version: 1.0
Implementation-Title: Gradle
Implementation-Version: ${PV}
Class-Path: gradle-base-services.jar gradle-core-api.jar gradle-core.jar
Main-Class: org.gradle.launcher.GradleMain" \
		> src/main/resources/META-INF/MANIFEST.MF \
		|| die "Failed to generate MANIFEST.MF"
}
