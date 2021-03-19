pkg_name=ansible
pkg_origin=core
pkg_version=2.11.0b2
pkg_description="Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy."
pkg_upstream_url="https://www.ansible.com/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=806996cf653f21e28086fffe66e2a0c1ae44dc0e723e4997255addc007632ad6
pkg_deps=(
  core/libffi
  core/python2
  core/sshpass
  core/openssl
)
pkg_build_deps=(
  core/gcc
  core/libyaml
  core/make
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  push_runtime_env PYTHONPATH "$(pkg_path_for python2)/lib/python2.7/site-packages"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python2.7/site-packages"
  push_runtime_env ANSIBLE_CONFIG "${pkg_prefix}/etc/ansible.cfg"
  push_buildtime_env LD_LIBRARY_PATH "$(pkg_path_for libffi)/lib"
}

do_prepare() {
  mkdir -p "${pkg_prefix}/lib/python2.7/site-packages"
  mkdir -p "${pkg_prefix}/share"
  mkdir -p "${pkg_prefix}/etc"
  # Fixes encoding error: Installed from requirements: MarkupSafe, jinja2, PyYAML, pycparser, cffi, enum34, ipaddress, cryptography
  pip install -r requirements.txt
  # Fixes version_helper issue converting between python 2to3
  pip install packaging
}

do_build() {
  make
}

do_install() {
  python setup.py install \
    --prefix="${pkg_prefix}" \
    --optimize=1 \
    --skip-build
  cp -dpr examples/* "${pkg_prefix}/share/"
  install -Dm644 examples/ansible.cfg "${pkg_prefix}/etc/ansible.cfg"
}
