# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/commons-collections:0
	dev-java/commons-compress:0
	dev-java/commons-io:0
	dev-java/commons-lang:2
	~dev-java/gradle-base-services-${PV}:${SLOT}
	~dev-java/gradle-base-services-groovy-${PV}:${SLOT}
	~dev-java/gradle-build-cache-${PV}:${SLOT}
	~dev-java/gradle-build-option-${PV}:${SLOT}
	~dev-java/gradle-cli-${PV}:${SLOT}
	~dev-java/gradle-core-api-${PV}:${SLOT}
	~dev-java/gradle-jvm-services-${PV}:${SLOT}
	~dev-java/gradle-logging-${PV}:${SLOT}
	~dev-java/gradle-messaging-${PV}:${SLOT}
	~dev-java/gradle-model-core-${PV}:${SLOT}
	~dev-java/gradle-model-groovy-${PV}:${SLOT}
	~dev-java/gradle-native-${PV}:${SLOT}
	~dev-java/gradle-persistent-cache-${PV}:${SLOT}
	~dev-java/gradle-process-services-${PV}:${SLOT}
	~dev-java/gradle-resources-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/groovy-ant:0
	dev-java/groovy-json:0
	dev-java/groovy-templates:0
	dev-java/groovy-xml:0
	dev-java/guava:26
	dev-java/javax-inject:0
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/native-platform:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	local f files

	sed -i -e "s|-\\\|(-\\\|" -e "s|\\\\\\\.jar|)?\\\\\\\.jar|" \
		src/main/java/org/gradle/api/internal/classpath/DefaultModuleRegistry.java \
		|| die "Failed to modify jar regex"

	sed -i -e "/import static.*com.google.common.collect.Iterators.*/d" \
		-e "26iimport java.util.Collections;" \
		-e "26iimport java.util.Set;" \
		-e "s|emptyIterator|Collections.emptyIterator|g" \
		-e "s|singletonIterator|(Iterator<TaskStateChange>)Collections.singleton|g" \
		src/main/java/org/gradle/api/internal/changedetection/state/TaskFilePropertyCompareStrategy.java \
		|| die "Failed to sed/fix guava api changes"

	sed -i -e "s|Iterators.singletonIterator|(Iterator<TaskStateChange>)Collections.singleton|g" \
		src/main/java/org/gradle/api/internal/changedetection/rules/PreviousSuccessTaskStateChanges.java \
		|| die "Failed to sed/fix guava api changes"

	files=(
		api/internal/CompositeDomainObjectSet
		api/internal/DefaultDomainObjectCollection
		api/internal/changedetection/rules/PreviousSuccessTaskStateChanges
		api/internal/changedetection/state/DefaultFileCollectionSnapshot
		api/internal/changedetection/state/OrderInsensitiveTaskFilePropertyCompareStrategy
		api/internal/file/CompositeFileCollection
		api/internal/tasks/CompositeTaskOutputPropertySpec
		plugin/management/internal/DefaultPluginRequests
	)
	for f in ${files[@]}; do
		sed -i -e "s|com.google.common.collect.Iterators|java.util.Collections|" \
			-e "s|Iterators.empty|Collections.empty|g" \
			src/main/java/org/gradle/${f}.java \
			|| die "Failed to sed/fix guava api changes"
	done

	# add back import removed, switch to collections?
	sed -i -e "/java.util.Collection;/a import com.google.common.collect.Iterators;" \
		src/main/java/org/gradle/api/internal/CompositeDomainObjectSet.java \
		|| die "Failed to sed/fix guava api changes"

	sed -i -e 'N;s|});\n.*return|},com.google.common.util.concurrent.MoreExecutors.directExecutor());\n            return|;P;D' \
		src/main/java/org/gradle/internal/filewatch/jdk7/WatchServiceFileWatcherBacking.java \
		|| die "Failed to sed/fix guava api changes"

	sed -i -e "s|JAVA_ISO_CONTROL|javaIsoControl()|" \
		src/main/java/org/gradle/api/internal/tasks/userinput/DefaultUserInputHandler.java \
		|| die "Failed to sed/fix guava api changes"
}
