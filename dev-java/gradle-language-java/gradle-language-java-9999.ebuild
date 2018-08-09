# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/commons-lang:2
	dev-java/fastutil:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-core-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-dependency-management-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-language-jvm-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-platform-base-${PV}:${SLOT}
	~dev-java/gradle-platform-jvm-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-workers-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:26
	dev-java/javax-inject:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	local f

	for f in AnnotationProcessingCompile \
		ResourceCleaningCompilation ; do
	sed -i -e '59i\ \ \ \ @Override\n\ \ \ \ public void addModules(Iterable<String> moduleNames) {\n\ \ \ \ }\n' \
			src/main/java/org/gradle/api/internal/tasks/compile/${f}Task.java \
			|| die "Failed to sed/add java 11 method"
	done
}
