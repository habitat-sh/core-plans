#!/bin/bash

#
# check-security-features.sh: Report on compiler and linker-level
# security features for a given package.
#
error() {
  echo "$1" 2>&1
}

usage() {
  error "usage: $0 PACKAGE_NAME"
}

bins_for_pkg() {
  find "/hab/pkgs/$1" -type f -perm -u+w -print0 2> /dev/null \
    | while read -rd '' f; do
      case "$(file -bi "$f")" in
        *application/x-executable*) echo "$f";;
        *application/x-sharedlib*) echo "$f";;
        *) continue;;
      esac
   done
}


check_nx_stack() {
   if echo "$1" | grep -q "GNU_STACK.*RWX"; then
      echo "No"
   else
      echo "Yes"
   fi
}

check_relro() {
  if echo "$1" | grep -q "GNU_RELRO"; then
    echo "Yes"
  else
    echo "No"
  fi
}

check_bindnow() {
  if echo "$1" | grep -q "BIND_NOW"; then
    echo "Yes"
  else
    echo "No"
  fi
}

check_stack_canary() {
  if echo "$1" | grep -q "__stack_chk_fail"; then
    echo "Yes"
  else
    echo "No"
  fi
}

check_fortify() {
  if echo "$1" | grep -q "_chk@"; then
    echo "Yes"
  else
    echo "No"
  fi
}

run_readelf() {
  out=$(readelf -W -a "$filename")
  if [[ -z "$out" ]]; then
    error "readelf produced no output!"
    error "Is $filename a shared object or executable file?"
    exit 1
  fi
  echo "$out"
}

do_check() {
   filename=$1
   readelf_output=$(run_readelf)
   canary=$(check_stack_canary "$readelf_output")
   nx_stack=$(check_nx_stack "$readelf_output")
   fortify=$(check_fortify "$readelf_output")
   relro=$(check_relro "$readelf_output")
   bindnow=$(check_bindnow "$readelf_output")
   echo "${filename}%${canary}%${nx_stack}%${fortify}%${relro}%${bindnow}"
}

if [ -z "$1" ]; then
  error "No package name provided"
  usage
  exit 1
fi

header="FILENAME%STACK_CANARY%NX_STACK%FORTIFY%RELRO%BIND_NOW"
body=""

for file in $(bins_for_pkg "$1"); do
  body="${body}\n$(do_check "$file")"
done

echo -e "${header}\n${body}" | column -s'%' -t
