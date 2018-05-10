# Copyright 2017-2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

MY_PN="REL"
MY_PV="${PV//./_}"
MY_PV="${MY_PV^^}"
MY_P="${MY_PN}_${MY_PV}"
[[ ${PV} != *beta* ]] && MY_P+="_FINAL"

XSDS=( XAdES XAdESv141 ${PN}-xml ${PN}-xmldsig-core-schema
	${PN}-encryptionCertificate ${PN}-encryptionInfo
	${PN}-encryptionPassword ${PN}-signatureInfo ${PN}-visio )

inherit java-pkg

DESCRIPTION="Java API for Microsoft Documents ${PN:4}"
HOMEPAGE="https://poi.apache.org/"
LICENSE="Apache-2.0"
if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64"
fi
SLOT="0"
SRC_URI="
	https://raw.githubusercontent.com/apache/poi/${MY_P}/src/ooxml/resources/org/apache/poi/poifs/crypt/encryptionCertificate.xsd -> ${PN}-encryptionCertificate.xsd
	https://raw.githubusercontent.com/apache/poi/${MY_P}/src/ooxml/resources/org/apache/poi/poifs/crypt/encryptionInfo.xsd -> ${PN}-encryptionInfo.xsd
	https://raw.githubusercontent.com/apache/poi/${MY_P}/src/ooxml/resources/org/apache/poi/poifs/crypt/encryptionPassword.xsd -> ${PN}-encryptionPassword.xsd
	https://raw.githubusercontent.com/apache/poi/${MY_P}/src/ooxml/resources/org/apache/poi/poifs/crypt/signatureInfo.xsd -> ${PN}-signatureInfo.xsd
	https://raw.githubusercontent.com/apache/poi/${MY_P}/src/ooxml/resources/org/apache/poi/xdgf/visio.xsd -> ${PN}-visio.xsd
	http://www.ecma-international.org/publications/files/ECMA-ST/Office%20Open%20XML%201st%20edition%20Part%202%20(PDF).zip
	http://www.ecma-international.org/publications/files/ECMA-ST/Office%20Open%20XML%201st%20edition%20Part%204%20(PDF).zip
	http://uri.etsi.org/01903/v1.3.2/XAdES.xsd
	http://uri.etsi.org/01903/v1.4.1/XAdESv141.xsd
	https://www.w3.org/2001/xml.xsd -> ${PN}-xml.xsd
	https://www.w3.org/TR/2002/REC-xmldsig-core-20020212/xmldsig-core-schema.xsd -> ${PN}-xmldsig-core-schema.xsd
"

CP_DEPEND="dev-java/xmlbeans:0"

DEPEND="app-arch/unzip
	${CP_DEPEND}
	>=virtual/jdk-9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-9"

S="${WORKDIR}/${PN}/"

src_unpack() {
	default
	unpack "${WORKDIR}/OfficeOpenXML-XMLSchema.zip"
	unpack "${WORKDIR}/OpenPackagingConventions-XMLSchema.zip"
	local xsd
	for xsd in "${XSDS[@]}"; do
		cp "${DISTDIR}/${xsd}.xsd" "${WORKDIR}/${xsd/${PN}-/}.xsd" \
			|| die "Failed to copy ${xsd}.xsd to ${WORKDIR}"
	done
	mkdir "${S}" || die
}

java_prepare() {
	cd "${WORKDIR}" || die

	# Needed to correct various paths
	sed -i -e "s|2006|x2006|g" \
		-e "s|2012|x2012|g" \
		-e "s|01903|x01903|g" \
		-e "s|v1.3.2#|v13|g" \
		-e "s|v1.4.1#|v14|g" \
		-e 's|schemaLocation="http://uri.etsi.org/x01903/v1.3.2/|schemaLocation="|g' \
		-e 's|schemaLocation="http://www.w3.org/TR/2002/REC-xmldsig-core-20020212/|schemaLocation="|g' \
		-e "s|/2000/09/xmldsig#|/x2000/x09/xmldsig|g" \
		-e "s|2006/spreadsheetdrawing|2006/spreadsheetDrawing|g" \
		-e "s|2006/wordprocessingdrawing|2006/wordprocessingDrawing|g" \
		-e "s|schemas-microsoft-com:|com/microsoft/schemas/|g" \
		-e "s|/office:|/office/|g" \
		-e "s|/schemas:|/schemas/|g" \
		*.xsd || die "Could not sed xsd"

	sed -i -e 's|s"/>|s" schemaLocation="shared-relationshipReference.xsd"/>|' \
		visio.xsd || die "Could add schemaLocation to visio.xsd"

	local xsds
	xsds=(
		dml-chart
		dml-chartDrawing
		dml-picture
		dml-spreadsheetDrawing
		dml-table
		dml-wordprocessingDrawing
		opc-digSig
		opc-relationships
		pml-comments
		pml-slide
		pml-presentation
		shared-documentPropertiesExtended
		shared-documentPropertiesCustom
		sml-calculationChain
		sml-comments
		sml-customXmlMappings
		sml-pivotTable
		sml-sharedWorkbookRevisions
		sml-sheet
		sml-singleCellTable
		sml-supplementaryWorkbooks
		sml-styles
		sml-table
		vml-main
		vml-officeDrawing
		wml
		${XSDS[@]} )

	# Fails
	# xsds=( $(ls *xsd) )

	# This works with the list above
	for xsd in "${xsds[@]}"; do
		scomp -srconly -src "${S}" "${WORKDIR}/${xsd/${PN}-/}.xsd" \
			|| die "scomp failed on ${xsd}"
	done
}
