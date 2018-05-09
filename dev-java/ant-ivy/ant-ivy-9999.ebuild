# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="${PN}"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-${MY_PV}"
BASE_URI="https://github.com/apache/${PN}"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="${BASE_URI}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64"
	MY_S="${MY_P}"
fi

inherit java-pkg

DESCRIPTION="Tool for managing project dependencies"
HOMEPAGE="https://ant.apache.org/ivy/"
LICENSE="Apache-2.0"
SLOT="0"

BC_SLOT="1.59"

CP_DEPEND="
	dev-java/ant-core:0
	dev-java/bcpg:${BC_SLOT}
	dev-java/bcprov:${BC_SLOT}
	dev-java/commons-httpclient:0
	dev-java/commons-vfs:2
	dev-java/jakarta-oro:0
	dev-java/jsch:0
	dev-java/jsch-agent-proxy-core:0
	dev-java/jsch-agent-proxy-connector-factory:0
	dev-java/jsch-agent-proxy-jsch:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${MY_S}"

java_prepare() {
	local f p

	sed -i -e "s|public Object clone|public FileSet clone|" \
		src/java/org/apache/ivy/ant/IvyCacheFileset.java \
		|| die "Failed to sed/fix incompatible return type"

	# update to commons-vfs:2
	p="src/java/org/apache/ivy/plugins"
	for f in Resource Repository; do
		sed -i -e "s|commons.vfs|commons.vfs2|g" \
			${p}/repository/vfs/Vfs${f}.java \
			|| die "Failed to sed vfs -> vfs2"
	done

	# update bcpg
	sed -i -e "s|initSign|init|" -e "105d;107d" \
		-e "44iimport org.bouncycastle.openpgp.operator.bc.BcKeyFingerprintCalculator;" \
		-e "44iimport org.bouncycastle.openpgp.operator.bc.BcPBESecretKeyDecryptorBuilder;" \
		-e "44iimport org.bouncycastle.openpgp.operator.bc.BcPGPContentSignerBuilder;" \
		-e "44iimport org.bouncycastle.openpgp.operator.bc.BcPGPDigestCalculatorProvider;" \
		-e "s|RingCollection(in)|RingCollection(PGPUtil.getDecoderStream(in),new BcKeyFingerprintCalculator())|" \
		-e "s|extractPrivateKey(.*|extractPrivateKey(new BcPBESecretKeyDecryptorBuilder(new BcPGPDigestCalculatorProvider()).build(password.toCharArray()));|" \
		-e "s|pgpSec.getPublicKey()|new BcPGPContentSignerBuilder(pgpSec.getPublicKey().getAlgorithm(), PGPUtil.SHA1));|" \
		-e "/SignatureException e/,+3d" \
		-e "/NoSuchAlgorithmException e/,+3d" \
		-e "/NoSuchProviderException e/,+3d" \
		${p}/signer/bouncycastle/OpenPGPSignatureGenerator.java \
		|| die "Failed to sed/update bc"
}
