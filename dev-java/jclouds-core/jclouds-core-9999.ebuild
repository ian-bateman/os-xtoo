# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="jclouds"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${MY_PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/rel/${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_PN}-rel-${MY_P}"
fi

SLOT="0"

GUICE_SLOT="4"

CP_DEPEND="
	dev-java/auto-service:0
	dev-java/auto-common:0
	dev-java/error-prone-annotations:0
	dev-java/gson:0
	dev-java/guava:25
	dev-java/guice:${GUICE_SLOT}
	dev-java/guice-extensions-assistedinject:${GUICE_SLOT}
	dev-java/javax-annotation:0
	dev-java/javax-inject:0
	dev-java/jax-rs:2
	dev-java/jaxb-api:0
	dev-java/osgi-core-api:6
"

inherit java-pkg

DESCRIPTION="JClouds Core"
HOMEPAGE="https://jclouds.apache.org/"
LICENSE="Apache-2.0"

S="${WORKDIR}/${MY_S}/${PN##*-}"

java_prepare() {
	local f

	sed -i -e "s|import static com.google.common.base.Functions.compose|import com.google.common.base.Functions|" \
		-e "s| compose(|Functions.compose(|g" \
		src/main/java/org/jclouds/rest/internal/TransformerForRequest.java \
		|| die "Failed to sed/fix guava class change ${f}"

	for f in $( grep -l -m1 getHostText -r * ); do
		sed -i -e "s|getHostText|getHost|g" ${f} \
			|| die "Failed to sed/fix guava method renamed ${f}"
	done

	sed -i -e 's|"excluder")|"excluder"), null|' \
		src/main/java/org/jclouds/json/internal/DeserializationConstructorAndReflectiveTypeAdapterFactory.java \
		|| die "Failed to sed/fix gson constructor change"

	sed -i -e "s|NANOSECONDS, true|NANOSECONDS|" \
		src/main/java/org/jclouds/rest/internal/InvokeHttpMethod.java \
		|| die "Failed to sed/fix guava method argument change"
}
