pkg_name=ansible
pkg_origin=core
pkg_version="2.4.3.0-1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="0bcb583f2abaa580c337462a81903ff3f925d10c367da466c2c0354479432683"
pkg_deps=(
  core/libffi
  core/python2
  core/sshpass
)
pkg_build_deps=(
  core/gcc
  core/libyaml
  core/make
  core/openssl
)
pkg_bin_dirs=(bin)
pkg_description="Ansible is a radically simple IT automation platform that makes your applications \
and systems easier to deploy. Avoid writing scripts or custom code to deploy and update your \
applications— automate in a language that approaches plain English, using SSH, with no agents to \
install on remote systems."
pkg_upstream_url="https://www.ansible.com/"

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
}

do_build() {
  python setup.py build
}

do_install() {
  python setup.py install \
    --prefix="${pkg_prefix}" \
    --optimize=1 \
    --skip-build
  cp -dpr examples/* "${pkg_prefix}/share/"
  install -Dm644 examples/ansible.cfg "${pkg_prefix}/etc/ansible.cfg"
}
