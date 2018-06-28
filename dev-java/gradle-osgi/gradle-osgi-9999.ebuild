# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/aqute-jpm-clnt:0
	dev-java/bndlib:4
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-platform-jvm-${PV}:${SLOT}
	~dev-java/gradle-plugins-${PV}:${SLOT}
	dev-java/groovy:0
"

inherit gradle
