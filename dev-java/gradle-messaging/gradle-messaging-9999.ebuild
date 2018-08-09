# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SLOT="0"

CP_DEPEND="
	dev-java/commons-lang:2
	dev-java/fastutil:0
	~dev-java/gradle-base-services-${PV}:${SLOT}
	dev-java/guava:26
	dev-java/jcip-annotations:0
	dev-java/jsr305:0
	dev-java/kryo:0
	dev-java/slf4j-api:0
"

inherit gradle

java_prepare() {
	local f

	for f in StringDeduplicating ""; do
		sed -i -e "s|output.total()|new Long(output.total()).intValue()|" \
			src/main/java/org/gradle/internal/serialize/kryo/${f}KryoBackedEncoder.java \
			|| die "Failed to sed/fix lossy conversion"
	done
}
