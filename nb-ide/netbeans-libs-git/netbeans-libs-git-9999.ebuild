# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit java-netbeans

CP_DEPEND="
	dev-java/eclipse-jgit:0
	dev-java/jsch:0
	dev-java/jsch-agent-proxy-core:0
	~nb-ide/netbeans-libs-jsch-agentproxy-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-${PV}:${SLOT}
	~nb-ide/netbeans-openide-util-lookup-${PV}:${SLOT}
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

java_prepare() {
	local f files

	sed -i -e  "s|extends org.eclipse.jgit.ignore.IgnoreRule|extends org.eclipse.jgit.ignore.FastIgnoreRule|" \
		src/org/netbeans/libs/git/jgit/IgnoreRule.java \
		|| die "Failed to sed/fix IngoreRule -> FastIngoreRule"

	sed -i -e  "s|repository, file, e|repository, e|" \
		src/org/netbeans/libs/git/jgit/utils/CheckoutIndex.java \
		|| die "Failed to sed/fix number of arguments"

	files=(
		Add CheckoutRevision Compare ExportCommit ExportDiff
		GetCommonAncestor GetPreviousCommit ListTag Log Revert
		Status StashList
	)
	files=( ${files[@]/#/jgit\/commands\/} )
	files=( ${files[@]/%/Command} )
	files+=( GitRevisionInfo jgit/utils/CheckoutIndex )

	for f in "${files[@]}"; do
		sed -i -e '/release();/d' \
			"src/org/netbeans/libs/git/${f}.java" \
			|| die "Failed to remove release from ${f}.java"
	done
}
