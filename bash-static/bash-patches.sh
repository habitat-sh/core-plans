# The root URL for all official patch files
_patch_url_base="$_url_base/${_distname}-${_base_version}-patches/${_distname}${_base_version//.}"

# All official patch file URLs
_patch_files=(
  "${_patch_url_base}-001"
  "${_patch_url_base}-002"
  "${_patch_url_base}-003"
  "${_patch_url_base}-004"
)

# All official patch file shasums
_patch_shasums=(
  ebb07b3dbadd98598f078125d0ae0d699295978a5cdaef6282fe19adef45b5fa
  15ea6121a801e48e658ceee712ea9b88d4ded022046a6147550790caf04f5dbe
  22f2cc262f056b22966281babf4b0a2f84cb7dd2223422e5dcd013c3dcbab6b1
  9aaeb65664ef0d28c0067e47ba5652b518298b3b92d33327d84b98b28d873c86
)
