pkg_name=ansible
pkg_origin=core
pkg_version=2.11.0b2
pkg_description="Ansible is a radically simple IT automation platform that makes your applications and systems easier to deploy."
pkg_upstream_url="https://www.ansible.com/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_source="https://github.com/${pkg_name}/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=161c269d248576e0b56fe3386cbb0ee0beacab29f18607f971c2b3dc4fb62c4e
pkg_deps=(
  core/libffi
  core/python39
  core/sshpass
  core/openssl
)
pkg_build_deps=(
  core/gcc
  core/libyaml
  core/make
  core/coreutils
  core/busybox-static
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  push_runtime_env PYTHONPATH "$(pkg_path_for python)/lib/python3.9/site-packages"
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python3.9/site-packages"
  push_runtime_env ANSIBLE_CONFIG "${pkg_prefix}/etc/ansible.cfg"
  push_buildtime_env LD_LIBRARY_PATH "$(pkg_path_for libffi)/lib"
}

do_prepare() {
  python -m venv "$pkg_prefix"
  # shellcheck source=/dev/null
  source "$pkg_prefix/bin/activate"

  mkdir -p "${pkg_prefix}/lib/python3.9site-packages" \
           "${pkg_prefix}/share" \
           "${pkg_prefix}/etc"

  pip install -r requirements.txt
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
