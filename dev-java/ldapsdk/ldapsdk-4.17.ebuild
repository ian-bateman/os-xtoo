# Copyright 2018 Obsidian-Studios, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

JAVA_PKG_IUSE="doc source"

CP_DEPEND="
	dev-java/jakarta-oro:0
	dev-java/jss:0
"

inherit java-pkg

DESCRIPTION="Netscape Directory SDK for Java"
HOMEPAGE="https://www-archive.mozilla.org/directory/javasdk.html"
SRC_URI="https://www-archive.mozilla.org/directory/ldapsdk_java_20020819.tar.gz"
KEYWORDS="~amd64"
LICENSE="MPL-1.1"
SLOT="0"

S="${WORKDIR}//mozilla/directory/java-sdk/"

JAVA_SRC_DIR="ietfldap/org ldapfilter ldapjdk ldapsp tools"

java_prepare() {
	local f files

	files=(
		ietfldap/org/ietf/ldap/util/RDN
		ietfldap/org/ietf/ldap/controls/LDAPEntryChangeControl
		ietfldap/org/ietf/ldap/controls/LDAPPersistSearchControl
		ldapjdk/netscape/ldap/util/RDN
		ldapjdk/netscape/ldap/controls/LDAPEntryChangeControl
		ldapjdk/netscape/ldap/controls/LDAPPersistSearchControl
		ldapjdk/netscape/ldap/LDAPConnection
		ldapsp/com/netscape/jndi/ldap/ObjectMapper
		ldapsp/com/netscape/jndi/ldap/AttributesImpl
	)
	for f in "${files[@]}" ; do
		sed -i -e "s|enum|anum|g" "${f}.java" \
			|| die "Failed to sed enum -> e ${f}.java"
	done

	for f in FilterDescriptor IntFilterList IntFilterSet ; do
		sed -i -e "s|com.oroinc|org.apache.oro|" \
			ldapfilter/netscape/ldap/util/LDAP${f}.java \
			|| die "Failed to sed oro import"
	done
}
