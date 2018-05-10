# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}3"
MY_PV="${PV}"
MY_P="${MY_PN}-${MY_PV}"

BASE_URI="https://github.com/${PN}/${MY_PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="An implementation of Python written in Java"
HOMEPAGE="https://www.jython.org"
LICENSE="PSF-2"
SLOT="${PV%*.*}"

ANTLR_SLOT="3"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/antlr:${ANTLR_SLOT}
	dev-java/asm:6
	dev-java/commons-compress:0
	dev-java/guava:24
	dev-java/jffi:0
	dev-java/jline:2
	dev-java/jnr-constants:0
	dev-java/jnr-posix:3
	java-virtuals/servlet-api:4.0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}/"

java_prepare() {
	# need to package oracle and informix
	# outdated in tree, likely not used
	rm src/com/ziclix/python/sql/handler/{Oracle,Informix}DataHandler.java \
		|| die "Failed to remove oracle and informix data handlers"

	local f files
	antlr${ANTLR_SLOT} -fo src/org/python/antlr \
		-lib src/org/python/antlr \
		grammar/{Python,PythonPartial}.g \
		|| die "Failed to process antlr grammar files"

	# upgrade to antlr4 not possible missing classes from older
#	for f in antlr antlr/ast antlr/base; do
#		sed -i -e "s|g.antlr.r|g.antlr.v4.r|g" \
#			src/org/python/${f}/*.java \
#			|| die "Failed to sed upgrade antlr -> antlr4"
#	done
}

src_install() {
	java-pkg-simple_src_install

	local java_args instdir
	instdir=/usr/share/${PN}-${SLOT}

	insinto ${instdir}
	doins -r Lib

	java_args=(
		-Dpython.home="${EPREFIX}${instdir}"
		-Dpython.executable="${EPREFIX}"/usr/bin/jython${SLOT}
		-Dpython.cachedir="\${HOME}/.jythoncachedir"
	)
	java-pkg_dolauncher jython${SLOT} \
		--main org.python.util.jython \
		--java_args "${java_args[*]}"

	local p cp
	for p in ${CP_DEPEND};do
		p="${p/*\//}"
		p="${p/:0/}"
		cp+="${p},"
	done
	cp="${cp/4.0,/4.0}"

	# following from ebuild in tree
	# we need a wrapper to help python_optimize
	cat <<-EOF > "${T}"/jython
		exec java -cp "$(java-pkg_getjars ${cp}):${PN}.jar" \
			-Dpython.home="${ED}${instdir}" \
			-Dpython.cachedir="${T}/.jythoncachedir" \
			-Duser.home="${T}" \
			org.python.util.jython "\${@}"
	EOF
	chmod +x "${T}"/jython || die

	local -x PYTHON="${T}"/jython
	# we can't get the path from the interpreter since it does some
	# magic that fails on non-installed copy...
	local PYTHON_SITEDIR
	PYTHON_SITEDIR=${EPREFIX}${instdir}/Lib/site-packages
	python_export jython${SLOT} EPYTHON

	# compile tests (everything else is compiled already)
	# we're keeping it quiet since jython reports errors verbosely
	# and some of the tests are supposed to trigger compile errors
	python_optimize "${ED}${instdir}"/Lib/test &>/dev/null

	# for python-exec
	echo "EPYTHON='${EPYTHON}'" > epython.py || die
	python_domodule epython.py

	# some of the class files end up with newer timestamps than the files they
	# were generated from, make sure this doesn't happen
	find "${ED}${instdir}"/Lib/ -name '*.class' | xargs touch
}
