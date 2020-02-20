pkg_name=grpc-cpp
pkg_distname=grpc
pkg_origin=core
pkg_version="1.25.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/grpc/grpc.git"
pkg_shasum=noshasum

pkg_deps=(
    core/glibc
    core/gcc-libs
    core/zlib
    core/openssl
    core/protobuf
    core/c-ares
)
pkg_build_deps=(
    core/make
    core/go
    core/git
    core/gcc
    core/cmake
    core/pkg-config
    core/llvm
    core/python
    core/virtualenv
    core/busybox-static
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_description="A high performance, open-source universal RPC framework"
pkg_upstream_url="https://grpc.io"

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  # making a cmake builddir that is the same as where the grpc tests expect it
  set_buildtime_env BUILDDIR "cmake/build"

  # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
  push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib/cmake/grpc"
}

do_download() {
  return 0
}

do_verify() {
  return 0
}

# Use unpack instead of download, so that plan-build can manage the
# source path. This ensures us a clean checkout every time we build.
do_unpack() {
  REPO_PATH="$HAB_CACHE_SRC_PATH/$pkg_dirname"

  git clone "$pkg_source" "$REPO_PATH"

  pushd "$REPO_PATH" || exit 1
  git checkout "tags/v${pkg_version}"
  git submodule init
  git submodule update
  popd || exit 1
}

do_prepare() {
  mkdir -p "${BUILDDIR}"

  # fix interpreter for benchmark
  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname/third_party/benchmark/tools" || exit 1
  _pythonpath="$(pkg_path_for core/python)"
  sed -e "s#/usr/bin/env python.*#${_pythonpath}/bin/python#" -i strip_asm.py
  popd || exit 1
}

do_build() {
  ZLIB_PATH="$(pkg_path_for zlib)"
  PROTOBUF_PATH="$(pkg_path_for protobuf)"

  pushd "${BUILDDIR}" || exit 1
  cmake \
    -DCMAKE_FIND_ROOT_PATH="${CMAKE_FIND_ROOT_PATH}" \
    -DgRPC_BUILD_TESTS="${DO_CHECK}" \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DgRPC_ZLIB_PROVIDER="package" \
    -DZLIB_ROOT="${ZLIB_PATH}" \
    -DgRPC_CARES_PROVIDER="package" \
    -DgRPC_PROTOBUF_PROVIDER="package" \
    -DProtobuf_INCLUDE_DIR="${PROTOBUF_PATH}/include" \
    -DProtobuf_LIBRARY="${PROTOBUF_PATH}/lib/libprotobuf.so" \
    -DProtobuf_PROTOC_LIBRARY="${PROTOBUF_PATH}/lib/libprotoc.so" \
    -DgRPC_SSL_PROVIDER="package" \
    -G "Unix Makefiles" \
    ../..
  make -j"$(nproc --ignore=1)"
  popd || exit 1
}

do_check() {
  testdir="${BUILDDIR}/testenv"
  fulltestdir_path="$(realpath "$testdir")"

  # clean up existing testenv
  rm -rf "${testdir}"

  # setup env
  virtualenv "${testdir}"
  source "${testdir}/bin/activate"

  # add py deps
  pip install six
  pip install pyyaml
  pip install twisted
  pip install httplib2

  # fix the interpreters without adding more runtime deps
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/python_utils/antagonist.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/start_port_server.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/core/http/test_server.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/core/bad_client/gen_build_yaml.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/core/bad_ssl/gen_build_yaml.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/core/end2end/fuzzers/generate_client_examples_of_bad_closing_streams.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/cpp/naming/resolver_component_tests_runner.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/cpp/naming/utils/tcp_connect.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/cpp/naming/utils/dns_server.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/cpp/naming/utils/dns_resolver.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i test/cpp/naming/utils/run_dns_server_for_lb_interop_tests.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/sanity/check_port_platform.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/sanity/check_version.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/sanity/core_banned_functions.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/sanity/check_deprecated_grpc++.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/performance/patch_scenario_results_schema.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/task_runner.py
  sed -e "s#/usr/bin/env python.*#${fulltestdir_path}/bin/python2#" -i tools/run_tests/run_tests.py

  # fix paths to tests
  sed -e "s#\-\-generated_file_path=gens#\-\-generated_file_path=${BUILDDIR}/gens#g" \
      -i tools/run_tests/generated/tests.json

  # increase file limits
  ulimit -n 1000000

  # run tests
  if ifconfig | grep -q "inet6"; then
    build_line "IPV6 Support"
    GTEST_FILTER="-BM_*" python tools/run_tests/run_tests.py \
    --language c++ \
    --compiler cmake \
    --allow_flakes --auto_set_flakes \
    --quiet_success
  else
    build_line "No IPV6 Support"

    # prevent checking for ipv6 in tools/run_tests/python_utils/port_server.py
    patch -p0 -i "${PLAN_CONTEXT}/no_ipv6_port_server.patch"

    # NOTE: these tests need to get excluded because they require ipv6
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6Loopback  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestPrefersIpv6LoopbackInputsFlipped  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/address_sorting_test_unsecure --gtest_filter=AddressSortingTest.TestSorterKnowsIpv6LoopbackIsAvailable  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestCancelActiveDNSQuery  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestCancelActiveDNSQuery  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestCancelActiveDNSQuery  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestFdsAreDeletedFromPollsetSet  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestFdsAreDeletedFromPollsetSet  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestFdsAreDeletedFromPollsetSet  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionIsGraceful  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionIsGraceful  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionIsGraceful  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithZeroQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithZeroQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/cancel_ares_query_test --gtest_filter=CancelDuringAresQuery.TestHitDeadlineAndDestroyChannelDuringAresResolutionWithZeroQueryTimeoutIsGraceful  GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/resolver_component_tests_runner_invoker --test_bin_name=resolver_component_test --running_under_bazel=false GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/resolver_component_tests_runner_invoker --test_bin_name=resolver_component_test --running_under_bazel=false GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/resolver_component_tests_runner_invoker --test_bin_name=resolver_component_test --running_under_bazel=false GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/resolver_component_tests_runner_invoker_unsecure --test_bin_name=resolver_component_test_unsecure --running_under_bazel=false GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/resolver_component_tests_runner_invoker_unsecure --test_bin_name=resolver_component_test_unsecure --running_under_bazel=false GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/resolver_component_tests_runner_invoker_unsecure --test_bin_name=resolver_component_test_unsecure --running_under_bazel=false GRPC_POLL_STRATEGY=poll-cv
    # FAILED: cmake/build/server_request_call_test --gtest_filter=ServerRequestCallTest.ShortDeadlineDoesNotCauseOkayFalse  GRPC_POLL_STRATEGY=epoll1
    # FAILED: cmake/build/server_request_call_test --gtest_filter=ServerRequestCallTest.ShortDeadlineDoesNotCauseOkayFalse  GRPC_POLL_STRATEGY=poll
    # FAILED: cmake/build/server_request_call_test --gtest_filter=ServerRequestCallTest.ShortDeadlineDoesNotCauseOkayFalse  GRPC_POLL_STRATEGY=poll-cv
    GTEST_FILTER="-BM_*:AddressSortingTest.TestPrefersIpv6Loopback*:AddressSortingTest.TestSorterKnowsIpv6Loopback*:ServerRequestCallTest.*:CancelDuringAresQuery.*:ResolverComponentTest.*" python tools/run_tests/run_tests.py \
      --language c++ \
      --compiler cmake \
      --allow_flakes --auto_set_flakes \
      --quiet_success
  fi
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  make install

  # remove third party libs
  # remove gflags
  rm -rfv "${pkg_prefix}/lib/libgflags.a"
  rm -rfv "${pkg_prefix}/lib/libgflags_nothreads.a"
  rm -rfv "${pkg_prefix}/include/gflags"
  rm -rfv "${pkg_prefix}/lib/cmake/gflags"
  rm -rfv "${pkg_prefix}/bin/gflags_completions.sh"
  rm -rfv "${pkg_prefix}/lib/pkgconfig/gflags.pc"

  # remove benchmark
  rm -rfv "${pkg_prefix}/lib/libbenchmark.a"
  rm -rfv "${pkg_prefix}/include/benchmark"
  rm -rfv "${pkg_prefix}/lib/cmake/benchmark"

  # remove pkgconfig folder since there is no config in there
  rm -rfv "${pkg_prefix}/lib/pkgconfig"
  popd || exit 1
}
