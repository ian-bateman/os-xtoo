# Copyright 2017 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

JAVA_PKG_IUSE="doc source"

XSDS=( XAdES XAdESv141 ${PN}-xml ${PN}-xmldsig-core-schema )

inherit java-pkg-2 java-pkg-simple ${ECLASS}

DESCRIPTION="Java API for Microsoft Documents ${PN:4}"
HOMEPAGE="https://poi.apache.org/"
LICENSE="Apache-2.0"
if [[ ${PV} != 9999 ]]; then
	KEYWORDS="~amd64"
fi
SLOT="0"
SRC_URI="
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
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

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

	local xsds
	xsds=(
		dml-chart
		dml-picture
		dml-spreadsheetDrawing
		dml-table
		dml-wordprocessingDrawing
		opc-digSig
		opc-relationships
		pml-comments
		pml-slide
		pml-presentation
		sml-calculationChain
		sml-comments
		sml-customXmlMappings
		sml-pivotTable
		sml-sharedWorkbookRevisions
		sml-sheet
		sml-singleCellTable
		sml-supplementaryWorkbooks
		sml-table
		vml-main
		vml-officeDrawing
		wml
		"${XSDS[@]:1}" )

	# Takes to long to parse all, and lots of duplicates and fails
	# xsds=( $(ls *xsd) )

	# This works with the list above
	for xsd in "${xsds[@]}"; do
		scomp -srconly -src "${S}" "${WORKDIR}/${xsd/${PN}-/}.xsd" \
			|| eerror "Failed on ${xsd}"
	done
}
