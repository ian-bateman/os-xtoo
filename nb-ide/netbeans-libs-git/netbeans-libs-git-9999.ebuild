# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

NB_CLUSTER="ide"

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

	# https://github.com/eclipse/jgit/commit/50436cc
	sed -i -e "/io.SafeBufferedOutputStream;/d" -e "s|Safe||" \
		-e '/while (treeWalk.next())/i\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ boolean hasAttributeNodeProvider = treeWalk.getAttributesNodeProvider() != null;' \
		-e 's|ignoreConflicts))|ignoreConflicts, hasAttributeNodeProvider ? treeWalk.getAttributes(): new org.eclipse.jgit.attributes.Attributes()))|' \
		src/org/netbeans/libs/git/jgit/commands/CherryPickCommand.java \
		|| die "Failed to sed/fix removed class and method changes"

	# https://github.com/eclipse/jgit/commit/e1cfe09
	for f in $(grep -l -m1 getRef\( -r *); do
		sed -i -e "s|getRef(|findRef(|g" "${f}" \
			|| die "Failed to sed/change removed method"
	done

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
