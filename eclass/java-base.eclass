# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: java-base.eclass

# @MAINTAINER:
# William L. Thomson Jr. <wlt@o-sinc.com>

# @AUTHOR:
# William L. Thomson Jr. <wlt@o-sinc.com>

# Based on work from java-utils-2.eclass and others
# Copyright 2004-2015 Gentoo Foundation

# @BLURB: Base eclass for Java packages
# @DESCRIPTION:
# This eclass provides functionality which is used by java eclasses.
# It should not be inherited directly from an ebuild.

inherit eutils versionator multilib

# @VARIABLE: JAVA_DEPEND
# @INTERNAL
# @DESCRIPTION:
# This is a convience variable to be used from the other java eclasses.
JAVA_DEPEND="dev-java/java-config"

# @ECLASS-VARIABLE: JAVA_FORCE_VM
# @DEFAULT_UNSET
# @DESCRIPTION:
# Explicitly set a particular VM to use. If its not valid, it'll fall back to
# whatever /etc/java-config-2/build/jdk.conf would elect to use.
#
# Should only be used for testing and debugging.
#
# Example: use oracle-jdk-bin:9 to emerge foo:
# @CODE
#       JAVA_FORCE_VM=oracle-jdk-bin:9 emerge foo
# @CODE

# @ECLASS-VARIABLE: JAVA_RELEASE
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specify a non-standard Java target version for compilation
# (javac -target parameter).
# Normally this is determined from the jre/jdk version specified in RDEPEND.
# See java-pkg_get-release function below.
#
# Should generally only be used for testing and debugging.
#
# Use 8 source to emerge baz
# @CODE
#       JAVA_RELEASE=8 emerge baz
# @CODE
