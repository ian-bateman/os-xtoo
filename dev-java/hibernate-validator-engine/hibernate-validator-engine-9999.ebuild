# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN:0:19}"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${PN:0:9}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
fi

CP_DEPEND="
	dev-java/beanvalidation-api:2.0
	dev-java/classmate:0
	dev-java/eclipse-javax-persistence:2
	dev-java/javafx-base:0
	dev-java/jaxb-api:0
	dev-java/jboss-logging:0
	dev-java/jboss-logging-annotations:2
	dev-java/joda-time:0
	dev-java/jsoup:0
	dev-java/jsr354-api:0
	dev-java/paranamer:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="Hibernate Validator ${PN:20}"
HOMEPAGE="https://hibernate.org/validator"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"

DEPEND+=" dev-java/jaxb-xjc:0"

S="${WORKDIR}/${MY_P}/${PN:20}"

java_prepare() {
	xjc -enableIntrospection \
		-p org.hibernate.validator.internal.xml.binding \
		-extension -target 2.1 -d "${S}/src/main/java" \
		"${S}/src/main/xsd/validation-configuration-2.0.xsd" \
		"${S}/src/main/xsd/validation-mapping-2.0.xsd" \
		-b "${S}/src/main/xjb/binding-customization.xjb" \
		|| die "Failed to generate java files via xjc"
}
