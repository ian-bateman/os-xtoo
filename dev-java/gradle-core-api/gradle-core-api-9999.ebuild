# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/commons-lang:2
	dev-java/jsr305:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-build-cache-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/groovy-ant:0
	dev-java/guava:25
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e "19iimport com.google.common.base.MoreObjects;" \
		-e "s|Objects.to|MoreObjects.to|g" \
		src/main/java/org/gradle/api/tasks/util/internal/CachingPatternSpecFactory.java \
		|| die "Failed to sed/fix guava class change"
}
