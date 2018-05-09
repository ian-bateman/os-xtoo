# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# Copyright 1999-2014 Gentoo Foundation

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN}/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit eutils java-pkg

DESCRIPTION="Java-based Ruby interpreter implementation"
HOMEPAGE="https://${PN}.org/"
LICENSE="|| ( EPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"

RUBY_VERSION=2.4
RUBY_REVISION=0

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/asm:6
	dev-java/commons-bsf:0
	dev-java/bytelist:0
	dev-java/dirgra:0
	dev-java/options:0
	dev-java/invokebinder:0
	dev-java/jcodings:1
	dev-java/jitescript:0
	dev-java/jffi:0
	dev-java/jnr-constants:0
	dev-java/jnr-enxio:0
	dev-java/jnr-ffi:2
	dev-java/jnr-netdb:0
	dev-java/jnr-posix:3
	dev-java/jnr-unixsocket:0
	dev-java/joda-time:0
	dev-java/joni:0
	dev-java/jzlib:0
	dev-java/modulator:0
	dev-java/nailgun-server:0
	dev-java/osgi-core-api:4
	dev-java/slf4j-api:0
	dev-java/snakeyaml:0
	dev-java/unsafe-fences:0
"

DEPEND="${CP_DEPEND}
	dev-lang/ruby:${RUBY_VERSION}
	>=virtual/jdk-9
"

RDEPEND="${CP_DEPEND}
	dev-lang/ruby:${RUBY_VERSION}
	>=virtual/jre-9
"

S="${WORKDIR}/${P}"

PATCHES=(
	"${FILESDIR}/bash-launcher.patch"
)

JAVA_SRC_DIR="core/src/main/resources core/src/main/java"
JAVAC_ARGS+=" --add-exports java.base/sun.nio.cs=ALL-UNNAMED "
JAVAC_ARGS+=" --add-exports jdk.unsupported/sun.misc=ALL-UNNAMED "
JAVAC_ARGS+=" --add-modules java.xml.ws.annotation "

RUBY_HOME=/usr/share/${PN}/lib/ruby
SITE_RUBY=${RUBY_HOME}/site_ruby
GEMS=${RUBY_HOME}/gems

pkg_setup() {
	export RUBYOPT=""
	java-pkg

	local fail
	for directory in "${GEMS}" "${SITE_RUBY}"; do
		if [[ -L ${directory} ]]; then
			eerror "${directory} is a symlink. Please do the following to resolve the situation:"
			echo 'emerge -an app-portage/gentoolkit'
			echo 'equery -qC b '"${directory}"' | sort | uniq | sed s/^/=/ > /tmp/jruby.fix'
			echo 'emerge -1C $(< /tmp/jruby.fix)'
			echo "rm ${directory}"
			echo 'emerge -1 $(< /tmp/jruby.fix)'

			eerror "For more information, please see https://bugs.gentoo.org/show_bug.cgi?id=302187"
			fail="true"
		fi
	done

	if [[ -n ${fail} ]]; then
		die "Please address the above errors, then run emerge --resume"
	fi
}

java_prepare() {
	einfo "Fixing properties"
	JRUBY_CONSTANTS="core/src/main/resources/org/jruby/runtime/Constants.java"
	for repvar in $(grep "@.*@\".*;" ${JRUBY_CONSTANTS} | sed 's:.*@\(.*\)@.*:\1:') ; do
		VAR=$(grep "<${repvar}>" pom.xml | sed 's/.*>\(.*\)<\/.*/\1/')
		sed -i "s/@${repvar}@/${VAR}/" \
			${JRUBY_CONSTANTS} || die
	done
	sed -i "s/String VERSION = \".*\"/String VERSION = \"${PV}\"/" \
		${JRUBY_CONSTANTS} || die

	einfo "Setting Ruby version to use."
	sed -i -e "s/String jruby_revision = \"\"/String jruby_revision = \"${RUBY_REVISION}\"/" \
		-e "s/String jruby_default_ruby_version = \"\"/String jruby_default_ruby_version = \"${RUBY_VERSION}\"/" \
		${JRUBY_CONSTANTS} || die
}

src_compile() {
	java-pkg-simple_src_compile
	# Todo build ruby stuff to install
}

src_install() {
	java-pkg-simple_src_install

	newbin bin/jruby.bash jruby
	dobin bin/j{irb{,_swing},rubyc}

#	insinto "${RUBY_HOME}"
#	doins -r "${S}"/lib/ruby/{2.3,2.4,shared}

	# Remove all the references to RubyGems as we're just going to
	# install it through dev-ruby/rubygems.
#	find "${ED}${RUBY_HOME}" -type f \
#		'(' '(' -path '*rubygems*' -not -name 'jruby.rb' ')' -or -name 'ubygems.rb' -or -name 'datadir.rb' ')' \
#		-delete || die
}

pkg_postinst() {
	ewarn ""
	ewarn "Make sure RUBYOPT is unset in the environment when using JRuby:"
	ewarn ""
	ewarn "    export RUBYOPT=\"\""
	ewarn ""
}
