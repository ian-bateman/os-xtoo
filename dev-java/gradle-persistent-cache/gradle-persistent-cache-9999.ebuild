# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-collections:0
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	dev-java/guava:27
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	sed -i -e "/import static.*com.google.common.collect.Iterators.*/d" \
		-e "27iimport java.util.Collections;" \
		-e "s|Iterators.<File>emptyIterator|Collections.<File>emptyIterator|g" \
		src/main/java/org/gradle/cache/internal/SingleDepthFilesFinder.java \
		|| die "Failed to sed/fix guava api changes"
}
