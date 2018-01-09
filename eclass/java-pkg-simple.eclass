# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Based on eclass
# Copyright 2004-2015 Gentoo Foundation

# @ECLASS: java-pkg-simple.eclass
# @MAINTAINER:
# wlt@o-sinc.com
# @AUTHOR:
# William L. Thomson Jr. <wlt@o-sinc.com>
# Java maintainers (java@gentoo.org)
# @BLURB: Eclass for packaging Java software with ease.
# @DESCRIPTION:
# This class is intended to build pure Java packages from Java sources
# without the use of any build instructions shipped with the sources.
# There is no support for resources besides the generated class files,
# or for generating source files, or for controlling the META-INF of
# the resulting jar, although these issues may be addressed by an
# ebuild by putting corresponding files into the target directory
# before calling the src_compile function of this eclass.

inherit java-utils-2

if ! has java-pkg-2 ${INHERITED}; then
	eerror "java-pkg-simple eclass can only be inherited AFTER java-pkg-2"
fi

EXPORT_FUNCTIONS src_compile src_install

# We are only interested in finding all java source files, wherever they may be.
S="${WORKDIR}"

# @ECLASS-VARIABLE: JAVA_CLASSPATH
# @DEFAULT_UNSET
# @DESCRIPTION:
# Comma or space separated list of java packages to include in the
# class path. The packages will also be registered as runtime
# dependencies of this new package. Dependencies will be calculated
# transitively. See "jem -l" for appropriate package names.
#
# @CODE
#	JAVA_CLASSPATH="foo,bar-2"
# @CODE
JAVA_CLASSPATH=${JAVA_GENTOO_CLASSPATH}

# @ECLASS-VARIABLE: JAVA_CLASSPATH_EXTRA
# @DEFAULT_UNSET
# @DESCRIPTION:
# Extra list of colon separated path elements to be put on the
# classpath when compiling sources.
JAVA_CLASSPATH_EXTRA=${JAVA_GENTOO_CLASSPATH_EXTRA}

# @ECLASS-VARIABLE: JAVA_NO_JAR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to any value to skip jar creation, to manipulate sources after
# compile before creating jar.

# @ECLASS-VARIABLE: JAVA_NO_SRC
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to any value to skip compile of sources, for jars without classes

# @ECLASS-VARIABLE: JAVA_RES_DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Directories relative to ${S} which contain the resources of the
# application. The default of "" will be treated mostly as ${S}
# itself. For the generated source package (if source is listed in
# ${JAVA_PKG_IUSE}), it is important that these directories are
# actually the roots of the corresponding resource trees.
#
# @CODE
#	JAVA_RES_DIR="src/main/resources"
# @CODE

# @ECLASS-VARIABLE: JAVA_RES_FIND
# @DEFAULT_UNSET
# @DESCRIPTION:
# Pattern to pass to find to include/exclude files from resources
#
# @CODE
#	JAVA_RES_DIR="-not '*.java'"
# @CODE

# @ECLASS-VARIABLE: JAVA_SRC_DIR
# @DEFAULT_UNSET
# @DESCRIPTION:
# Directories relative to ${S} which contain the sources of the
# application. The default of "" will be treated mostly as ${S}
# itself. For the generated source package (if source is listed in
# ${JAVA_PKG_IUSE}), it is important that these directories are
# actually the roots of the corresponding source trees.
#
# @CODE
#	JAVA_SRC_DIR="src/java/org/gentoo"
# @CODE

# @ECLASS-VARIABLE: JAVA_ENCODING
# @DESCRIPTION:
# The character encoding used in the source files.
: ${JAVA_ENCODING:=UTF-8}

# @ECLASS-VARIABLE: JAVAC_ARGS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Additional arguments to be passed to javac.

# @ECLASS-VARIABLE: JAVADOC_ARGS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Additional arguments to be passed to javadoc.

# @ECLASS-VARIABLE: JAVA_JAR_FILENAME
# @DESCRIPTION:
# The name of the jar file to create and install.
: ${JAVA_JAR_FILENAME:=${PN}.jar}

# @FUNCTION: java-pkg-simple_create-jar
# @DESCRIPTION:
# Finds resources in sources and copies them to resources directory.
# If a resource directory is not set and exists, a default one will be created.
java-pkg-simple_res_in_src() {
	local f files r src

	if [[ -d "${JAVA_RES_DIR}" ]] ||
		[[ -d "${S}/src/main/resources" ]] ; then
		return 0;
	fi
	eshopts_push -s extglob
	JAVA_RES_DIR="${S}/src/main/resources"
	mkdir -p "${JAVA_RES_DIR}" || die "Failed to make resources dir"
	for src in ${JAVA_SRC_DIR}; do
		files=(
			$(find "${src}" -not -name '*.java' \
				-not -name '*.javacc' -not -name '*.groovy' \
				-not -name '*.html' ${JAVA_RES_FIND} -type f
			)
		)
		for f in "${files[@]}"; do
			r="${f%/*}"
			r="${r/+(java|src|src\/java|src\/main\/java)\//}"
			r="${JAVA_RES_DIR}/${r}"
			if [[ ! -d "${r}" ]]; then
				mkdir -p "${r}" || die "Failed to make dir ${r}"
			fi
			cp "${f}" "${r}" \
				|| die "Failed to copy ${f} to resources"
		done
	done

}

# @FUNCTION: java-pkg-simple_create-jar
# @DESCRIPTION:
# Create jar from compiled sources or other
java-pkg-simple_create-jar(){
	local classes jar_args

	[[ -z ${1} ]] && die "No directory specified to jar (arg 1)"

	classes="${1}"
	jar_args="cfmM ${JAVA_JAR_FILENAME} ${classes}/META-INF/"
	if [[ -z ${JAVA_RES_DIR} ]] && \
		[[ -d "${S}/src/main/resources" ]]; then
		JAVA_RES_DIR="src/main/resources"
		if [[ -d "${JAVA_RES_DIR}/meta-inf" ]]; then
			mv "${JAVA_RES_DIR}/meta-inf" \
				"${JAVA_RES_DIR}/META-INF" \
				|| die "Failed to upper case meta-inf"
		fi
	fi

	java-pkg-simple_res_in_src

	if [[ -n ${JAVA_RES_DIR} ]]; then
		local r
		for r in ${JAVA_RES_DIR}; do
			if [[ -d "${r}" ]]; then
				cp -r "${r}"/* ${classes} \
					|| die "Failed to cp resources for jar"
			fi
		done
	fi
	if [[ -f ${classes}/META-INF/MANIFEST.MF ]]; then
		jar_args+="MANIFEST.MF"
	elif [[ ! -f ${classes}/META-INF/manifest.mf ]]; then
		if [[ ! -d ${classes}/META-INF ]]; then
			mkdir ${classes}/META-INF \
				|| die "Failed to mkdir META-INF"
		fi
		echo -e "Manifest-Version: 1.0\nCreated-By: $(jem -f)" \
			> ${classes}/META-INF/manifest.mf \
			|| die "Failed to echo manifest.mf"
		jar_args+="manifest.mf"
	fi
	jar ${jar_args} -C ${classes} . || die "jar failed"
}

# @FUNCTION: java-pkg-simple_src_compile
# @DESCRIPTION:
# src_compile for simple bare source java packages. Finds all *.java
# sources in ${JAVA_SRC_DIR}, compiles them with the classpath
# calculated from ${JAVA_CLASSPATH}, and packages the resulting
# classes to ${JAVA_JAR_FILENAME}. Use ${JAVA_RES_DIR} to pass
# resource directories to be included in jar.
java-pkg-simple_src_compile() {
	local sources=sources.lst classes=target/classes apidoc=target/api

	# auto generate classpath
	java-pkg_gen-cp JAVA_CLASSPATH

	# Remove if exist, for multiple runs
	[[ -d target ]] && rm -fr target

	# gather sources
	if [[ -z ${JAVA_SRC_DIR} ]]; then
		if [[ -d "${S}/src/main/java" ]]; then
			JAVA_SRC_DIR="src/main/java"
		elif [[ -d "${S}/src/java" ]]; then
			JAVA_SRC_DIR="src/java"
		elif [[ -d "${S}/src/main" ]]; then
			JAVA_SRC_DIR="src/main"
		elif [[ -d "${S}/src" ]]; then
			JAVA_SRC_DIR="src"
		fi
	fi
	find ${JAVA_SRC_DIR:-*} -name \*.java > ${sources}
	if [[ -z ${JAVA_NO_SRC} ]] && [[ ! -s ${sources} ]]; then
		die "*.java files not found in ${JAVA_SRC_DIR}"
	fi
	mkdir -p ${classes} || die "Could not create target directory"

	# compile
	local classpath="${JAVA_CLASSPATH_EXTRA}" dependency
	for dependency in ${JAVA_CLASSPATH}; do
		classpath="${classpath}:$(java-pkg_getjars ${dependency})" \
			|| die "getjars failed for ${dependency}"
	done
	while [[ $classpath = *::* ]]; do classpath="${classpath//::/:}"; done
	classpath=${classpath%:}
	classpath=${classpath#:}
	debug-print "CLASSPATH=${classpath}"
	[[ -z ${JAVA_NO_SRC} ]] && \
		ejavac -d ${classes} -encoding ${JAVA_ENCODING} \
			${classpath:+-classpath ${classpath}} ${JAVAC_ARGS} \
			@${sources}

	# javadoc
	if has doc ${JAVA_PKG_IUSE} && use doc; then
		mkdir -p ${apidoc}
		ejavadoc -d ${apidoc} \
			-encoding ${JAVA_ENCODING} -docencoding UTF-8 -charset UTF-8 \
			${classpath:+-classpath ${classpath}} ${JAVADOC_ARGS:- -quiet ${JAVAC_ARGS}} \
			@${sources} || die "javadoc failed"
	fi

	# package
	[[ -z ${JAVA_NO_JAR} ]] && java-pkg-simple_create-jar ${classes}
}

# @FUNCTION: java-pkg-simple_src_install
# @DESCRIPTION:
# src_install for simple single jar java packages. Simply packages the
# contents from the target directory and installs it as
# ${JAVA_JAR_FILENAME}. If the file target/META-INF/MANIFEST.MF exists,
# it is used as the manifest of the created jar.
java-pkg-simple_src_install() {
	local sources=sources.lst classes=target/classes apidoc=target/api

	# main jar
	java-pkg_dojar ${JAVA_JAR_FILENAME}

	# javadoc
	if has doc ${JAVA_PKG_IUSE} && use doc; then
		java-pkg_dojavadoc ${apidoc}
	fi

	# dosrc
	if has source ${JAVA_PKG_IUSE} && use source; then
		local srcdirs=""
		if [[ ${JAVA_SRC_DIR} ]]; then
			local parent child
			for parent in ${JAVA_SRC_DIR}; do
				for child in ${parent}/*; do
					srcdirs="${srcdirs} ${child}"
				done
			done
		else
			# take all directories actually containing any sources
			srcdirs="$(cut -d/ -f1 ${sources} | sort -u)"
		fi
		java-pkg_dosrc ${srcdirs}
	fi
}
