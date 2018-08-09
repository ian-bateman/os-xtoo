# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-launcher-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-reporting-${PV}:${SLOT}
	~dev-java/gradle-testing-base-${PV}:${SLOT}
	~dev-java/gradle-testing-jvm-${PV}:${SLOT}
	~dev-java/gradle-tooling-api-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:26
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle
