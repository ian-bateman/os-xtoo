# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-io:0
	dev-java/commons-lang:2
	dev-java/guava:26
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/slf4j-api:0
"

inherit gradle

JAVAC_ARGS+=" --add-exports java.base/jdk.internal.misc=ALL-UNNAMED "

java_prepare() {
	sed -i -e "s|return composite(|return composite((Iterable<? extends Action<? super T>>)|" \
		src/main/java/org/gradle/internal/Actions.java \
		|| die "Failed to sed/fix no suitable method found"

	sed -i -e "s|sun.m|jdk.internal.m|" \
		src/main/java/org/gradle/internal/classloader/ClassLoaderUtils.java \
		|| die "Failed to sed/fix class package move"
}
