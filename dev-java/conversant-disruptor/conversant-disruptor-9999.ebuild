# Copyright 2016-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

BASE_URI="https://github.com/${PN/-//}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit java-pkg

DESCRIPTION="Conversant ConcurrentQueue and Disruptor BlockingQueue"
HOMEPAGE="${BASE_URI}"
LICENSE="Apache-2.0"
SLOT="0"

S="${WORKDIR}/${P/conversant-/}"

JAVAC_ARGS="--add-exports java.base/jdk.internal.vm.annotation=ALL-UNNAMED"

java_prepare() {
	local f files
	files=(
		AbstractWaitingCondition
		ContendedAtomicLong
		ContendedAtomicInteger
		MPMCConcurrentQueue
		MultithreadConcurrentQueue
		PushPullConcurrentQueue
	)
	for f in ${files[@]}; do
	sed -i -e "s|sun.misc.C|jdk.internal.vm.annotation.C|g" \
		src/main/java/com/conversantmedia/util/concurrent/${f}.java \
		|| die "Failed to sed @Contended for Java 9"
	done
}
