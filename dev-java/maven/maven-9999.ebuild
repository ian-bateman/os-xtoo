# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	MY_S="${PN}-${P}"
fi

SLOT="0"

inherit java-pkg

DESCRIPTION="Project Management and Comprehension Tool for Java"
HOMEPAGE="https://maven.apache.org"
LICENSE="Apache-2.0"

MR_SLOT="0"
SLF4J_SLOT="0"
WAGON_SLOT="0"

RDEPEND="
	dev-java/asm:7
	dev-java/aopalliance:1
	dev-java/cdi-api:0
	dev-java/cglib:3
	dev-java/commons-cli:1
	dev-java/commons-io:0
	dev-java/commons-lang:3
	dev-java/guava:27
	dev-java/guice:4
	dev-java/httpcomponents-client:4.5
	dev-java/httpcomponents-core:4.4
	dev-java/jansi:0
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	dev-java/jsoup:0
	~dev-java/maven-artifact-${PV}:${SLOT}
	~dev-java/maven-builder-support-${PV}:${SLOT}
	~dev-java/maven-compat-${PV}:${SLOT}
	~dev-java/maven-core-${PV}:${SLOT}
	~dev-java/maven-embedder-${PV}:${SLOT}
	~dev-java/maven-model-${PV}:${SLOT}
	~dev-java/maven-model-builder-${PV}:${SLOT}
	~dev-java/maven-plugin-api-${PV}:${SLOT}
	~dev-java/maven-repository-metadata-${PV}:${SLOT}
	dev-java/maven-resolver-api:${MR_SLOT}
	dev-java/maven-resolver-connector-basic:${MR_SLOT}
	dev-java/maven-resolver-impl:${MR_SLOT}
	~dev-java/maven-resolver-provider-${PV}:${SLOT}
	dev-java/maven-resolver-spi:${MR_SLOT}
	dev-java/maven-resolver-transport-wagon:${MR_SLOT}
	dev-java/maven-resolver-util:${MR_SLOT}
	~dev-java/maven-settings-${PV}:${SLOT}
	~dev-java/maven-settings-builder-${PV}:${SLOT}
	dev-java/maven-shared-utils:0
	~dev-java/maven-slf4j-provider-${PV}:${SLOT}
	dev-java/plexus-cipher:0
	dev-java/plexus-component-annotations:0
	dev-java/plexus-interpolation:0
	dev-java/plexus-sec-dispatcher:0
	dev-java/plexus-utils:0
	dev-java/sisu-inject:0
	dev-java/sisu-plexus:0
	dev-java/slf4j-api:${SLF4J_SLOT}
	dev-java/slf4j-jcl-over-slf4j:${SLF4J_SLOT}
	dev-java/slf4j-simple:${SLF4J_SLOT}
	dev-java/wagon-http:${WAGON_SLOT}
	dev-java/wagon-http-shared:${WAGON_SLOT}
	dev-java/wagon-file:${WAGON_SLOT}
	dev-java/wagon-provider-api:${WAGON_SLOT}
"

S="${WORKDIR}/${MY_S}/apache-${PN}/src"

java_prepare() {
	sed -i -e 's|exec "$JAVACMD"|exec "$JAVACMD" --add-opens java.base/java.lang=ALL-UNNAMED |' \
		-e "s|worlds-\*|worlds|" bin/mvn \
		|| die "Failed to sed/modify launcher"
}

src_compile() {
:
}

src_install() {
	local dep deps dest jar jars

	dest="/usr/share/${PN}/"

	exeinto "${dest}bin"
	doexe bin/{mvn,mvnDebug}
	dosym ../share/maven/bin/mvn /usr/bin/mvn

	dodir "${dest}"{boot,lib}
	for dep in ${RDEPEND[@]}; do
		einfo "${dep}"
		dep="${dep/*dev-java\//}"
		dep="${dep/-${PV}/}"
		dep="${dep/:0/}"
		dep="${dep/:/-}"
		jars="$(jem -p ${dep})"
		jars="${jars//:/ }"
		for jar in ${jars[@]}; do
			dosym "../../../../${jar}" "${dest}lib/${jar##*/}"
		done
	done

	jar=$( jem -p plexus-classworlds )
	dosym "../../../../${jar}" "${dest}boot/${jar##*/}"

	insinto "${dest}/bin"
	doins bin/m2.conf

	insinto "${dest}"
	doins -r conf
}
