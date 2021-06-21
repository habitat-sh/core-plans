pkg_name=asciinema
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-or-later")
pkg_description="Terminal session recorder"
pkg_upstream_url=https://github.com/asciinema/asciinema
pkg_build_deps=(core/gawk)
pkg_deps=(core/python)
pkg_bin_dirs=(bin)
pkg_version() {
  python -c "import xml.etree.ElementTree as ET, requests; r = requests.get('https://pypi.org/rss/project/asciinema/releases.xml'); xml = ET.fromstring(r.text); print(xml.find('channel/item/title').text)"
}

do_before() {
  update_pkg_version
}

do_prepare() {
  python -m venv "${pkg_prefix}"
  # shellcheck source=/dev/null
  source "${pkg_prefix}/bin/activate"
}

do_build() {
  return 0
}

do_install() {
  pip install "${pkg_name}==${pkg_version}"
  # Write out versions of all pip packages to package
  pip freeze > "${pkg_prefix}/requirements.txt"
}

do_strip() {
  return 0
}
