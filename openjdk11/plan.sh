pkg_origin=core
pkg_name=openjdk11
pkg_version=11.0.13+8
pkg_description=('OpenJDK is a free and open-source implementation of the Java Platform, Standard Edition. OpenJDK distribution from Adoptium')
pkg_license=("GPL-2.0-with-classpath-exception")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://adoptium.net
pkg_source=https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_linux_hotspot_11.0.13_8.tar.gz
pkg_shasum=3b1c0c34be4c894e64135a454f2d5aaa4bd10aea04ec2fa0c0efe6bb26528e30
pkg_dirname=jdk-${pkg_version}
pkg_deps=(
  core/glibc
	core/zlib
)
pkg_build_deps=(
	core/rsync
  core/patchelf
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source_dir=$HAB_CACHE_SRC_PATH/${pkg_dirname}

do_setup_environment() {
	set_runtime_env JAVA_HOME "$pkg_prefix"
}

do_build() {
	return 0
}

do_install() {
	pushd "${pkg_prefix}" || exit 1
	rsync -avz "${source_dir}/" .

	export LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/jli:${pkg_prefix}/lib/server:${pkg_prefix}/lib"

	build_line "Setting interpreter for all executables to '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
	build_line "Setting rpath for all libraries to '$LD_RUN_PATH'"

	find "$pkg_prefix"/{lib,bin} -type f -executable \
	-exec sh -c 'file -i "$1" | grep -q "x-pie-executable; charset=binary"' _ {} \; \
	-exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

	find "$pkg_prefix/lib" -type f -name "*.so" \
	-exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

	popd || exit 1
}

do_strip() {
	return 0
}
