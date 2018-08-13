# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="webservices-${PN%%-*}"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	MY_S="${MY_P}"
fi

CP_DEPEND="
	dev-java/apache-mime4j-core:0
	dev-java/commons-logging:0
	dev-java/javax-activation:0
	dev-java/jaxen:0
	dev-java/osgi-core-api:6
	dev-java/stax2-api:0
"

inherit java-pkg

DESCRIPTION="XML Infoset compliant object model implementation"
HOMEPAGE="https://ws.apache.org/axiom/"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${MY_S}/${PN}"

java_prepare() {
	sed -i -e '124i \ \ \ \ \ \ \ \ MimeConfig.Builder b = new MimeConfig.Builder();' \
		-e '124i \ \ \ \ \ \ \ \b.setStrictParsing(true);' \
		-e "s|new MimeConfig|b.build|" \
		-e "/config.setStrictParsing(true);/d" \
		src/main/java/org/apache/axiom/attachments/MIMEMessage.java \
		|| die "Failed to sed/upgrade mime4j"
}
