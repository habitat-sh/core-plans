_patch_url_base="${_url_base}/${_distname}-${_base_version}-patches/${_distname}${_base_version//.}"

# All official patch file URLs
_patch_files=(
  ${_patch_url_base}-001
  ${_patch_url_base}-002
  ${_patch_url_base}-003
)

# All official patch file shasums
_patch_shasums=(
  9ac1b3ac2ec7b1bf0709af047f2d7d2a34ccde353684e57c6b47ebca77d7a376
  8747c92c35d5db32eae99af66f17b384abaca961653e185677f9c9a571ed2d58
  9e43aa93378c7e9f7001d8174b1beb948deefa6799b6f581673f465b7d9d4780
)
