# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/asm:6
	~dev-java/gradle-base-services-${PV}:${SLOT}
	dev-java/groovy:0
	dev-java/guava:26
	dev-java/jsr305:0
"

inherit gradle

java_prepare() {
	sed -i -e "s|return doIntersect(|return doIntersect((Collection<? extends Spec<? super T>>)|" \
		-e "s|return doUnion(|return doUnion((Collection<? extends Spec<? super T>>)|" \
		src/main/java/org/gradle/api/specs/Specs.java \
		|| die "Failed to sed/fix no suitable method found"
}
