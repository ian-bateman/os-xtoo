# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/swaldman/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${PN}-${P}"
fi

CP_DEPEND="
	dev-java/mchange-commons-java:0
	java-virtuals/servlet-api:4.0
"

inherit java-pkg

DESCRIPTION="A mature, highly concurrent JDBC Connection pooling library"
HOMEPAGE="https://www.mchange.com/projects/c3p0"
LICENSE="|| ( LGPL-2.1 EPL-1.0 )"
SLOT="0"

S="${WORKDIR}/${MY_S}"

JAVAC_ARGS+=" --add-modules java.sql "

java_prepare() {
	rm -r src/java/com/mchange/v2/c3p0/test \
		|| die "Failed to remove tests"

	# never fails...
	debuggen \
		--codebase src/java \
		--packages=com.mchange \
		--recursive \
		--debug=false \
		--trace=5 \
		|| die "DebugGen failed"
}

src_compile() {
	JAVA_CLASSPATH_EXTRA="src/java"
	JAVA_JAR_FILENAME="codegen.jar"
	JAVA_SRC_DIR="src/java/com/mchange/v2/c3p0/codegen"
	java-pkg-simple_src_compile

	local cp f
	cp="codegen.jar:$(jem -p mchange-commons-java)"
	for f in DriverManager JndiRef PoolBacked WrapperConnectionPool; do
		f="com/mchange/v2/c3p0/impl/${f}DataSourceBase"
		java -cp "${cp}" \
			com.mchange.v2.c3p0.codegen.BeangenDataSourceGenerator \
			src/codegen/${f}.beangen-xml \
			src/java/${f}.java \
			|| die "Failed to generate ${f}.java"
	done

	java -cp "${cp}" \
		com.mchange.v2.c3p0.codegen.JdbcProxyGenerator \
		src/java \
		|| die "Failed to generate NewProxyConnection.java"

	JAVA_JAR_FILENAME="${PN}.jar"
	JAVA_SRC_DIR="src/java"
	java-pkg-simple_src_compile
}
