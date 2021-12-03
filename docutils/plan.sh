pkg_origin=core
pkg_name=docutils
pkg_version=0.18.1
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=(
  'GPL-3.0'
  'BSD-2-Clause-FreeBSD'
  'Python-2.0'
  'Docutils Public Domain Dedication'
)
pkg_source=https://downloads.sourceforge.net/project/${pkg_name}/${pkg_name}/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=679987caf361a7539d76e584cbeddc311e3aee937877c87346f31debc63e9d06
pkg_description="Docutils is an open-source text processing system for processing plaintext documentation into useful formats, e.g.: HTML, LaTeX, man-pages, open-document, or XML."
pkg_upstream_url="http://docutils.sourceforge.net"
pkg_deps=(
  core/bash
  core/python2
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  python setup.py install --prefix="$pkg_prefix"
}

do_setup_environment() {
  push_runtime_env PYTHONPATH "$(pkg_path_for python2)/lib/python2.7/site-packages"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python2.7/site-packages"
}

do_prepare() {
  mkdir -p "${pkg_prefix}/lib/python2.7/site-packages"
}

do_install() {
  python install.py

  # write our wrapper script
  bash_path=$(pkg_path_for core/bash)
  for file in "${pkg_prefix}"/bin/*.py; do
    # Rename executable to ${file}.real"
    mv "${file}" "${file}.real"
    # Write wrapper script to replace ${file}
    cat <<EOF > "${file}"
#!${bash_path}/bin/bash
export PYTHONPATH=$PYTHONPATH:${pkg_prefix}/lib/python2.7/site-packages
exec ${file}.real "\$@"
EOF
    # set the execute bit
    chmod a+x "${file}"
  done
}
