# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

SLF4J_SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-build-option-${PV}:${SLOT}
	~dev-java/gradle-cli-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	dev-java/guava:25
	dev-java/jansi:0
	dev-java/jansi-native:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:${SLF4J_SLOT}
	dev-java/slf4j-jul-to-slf4j:${SLF4J_SLOT}
"

inherit gradle

java_prepare() {
	sed -i -e "19iimport com.google.common.base.MoreObjects;" \
		-e "s|Objects.to|MoreObjects.to|" \
		src/main/java/org/gradle/internal/logging/console/Cursor.java \
		|| die "Failed to sed/fix guava class change"
}
