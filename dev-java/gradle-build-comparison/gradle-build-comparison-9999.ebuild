# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"
GROOVY_SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-ear-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-platform-jvm-${PV}:${SLOT}
	~dev-java/gradle-plugins-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	~dev-java/gradle-tooling-api-${PV}:${SLOT}
	dev-java/groovy:${GROOVY_SLOT}
	dev-java/groovy-xml:${GROOVY_SLOT}
	dev-java/guava:26
	dev-java/javax-inject:0
"

inherit gradle
