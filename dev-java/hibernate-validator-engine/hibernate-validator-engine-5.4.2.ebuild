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
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Hibernate Validator ${PN:20}"
HOMEPAGE="https://hibernate.org/validator"
LICENSE="Apache-2.0"
SLOT="${PV%%.*}"
IUSE="javafx"

CP_DEPEND="
	dev-java/beanvalidation-api:1.1
	dev-java/classmate:0
	dev-java/eclipse-javax-persistence:2
	dev-java/jaxb-api:0
	dev-java/jboss-logging:0
	dev-java/jboss-logging-annotations:2
	dev-java/joda-time:0
	dev-java/jsoup:0
	dev-java/jsr354-api:0
	dev-java/paranamer:0
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	dev-java/jaxb-xjc:0
	javafx? ( >=dev-java/oracle-jdk-bin-9[javafx] )
	!javafx? ( >=virtual/jdk-9 )"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_P}/${PN:20}"

java_prepare() {
	xjc -enableIntrospection \
		-p org.hibernate.validator.internal.xml.binding \
		-extension -target 2.1 -d "${S}/src/main/java" \
		"${S}/src/main/xsd/validation-configuration-1.1.xsd" \
		"${S}/src/main/xsd/validation-mapping-1.1.xsd" \
		-b "${S}/src/main/xjb/binding-customization.xjb" \
		|| die "Failed to generate java files via xjc"

	if ! use javafx; then
		rm -v "${S}/src/main/java/org/hibernate/validator/internal/engine/valuehandling/JavaFXPropertyValueUnwrapper.java" \
			|| die "Could not remove JavaFXPropertyValueUnwrapper.java"
	fi
}
