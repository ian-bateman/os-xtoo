# Run once, to avoid duplicate additions on each phase
[[ ${EBUILD_PHASE} != "clean" ]] && return 0

# no repackaging binaries
case ${PN} in
	*-bin | *-sources)
		FEATURES+=" -buildpkg"
		;;
esac

# skip pre-merge checks
case ${PN} in
	chromium | firefox)
		export I_KNOW_WHAT_I_AM_DOING=1
		;;
esac

# debug
case ${PN} in
	efl | enlightenment | glibc | terminology)
		CFLAGS+=" -ggdb"
		CXXFLAGS+=" -ggdb"
		FEATURES+=" compressdebug installsources -nostrip splitdebug"
		;;
esac
