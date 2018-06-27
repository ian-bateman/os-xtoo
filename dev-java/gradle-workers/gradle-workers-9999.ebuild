# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	dev-java/guava:25
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e "s|Objects|MoreObjects|g" \
		src/main/java/org/gradle/workers/internal/DaemonForkOptions.java \
		|| die "Failed to sed/fix guava class change"
}
