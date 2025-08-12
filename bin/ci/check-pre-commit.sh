echo "--- :python: Install pre-commit"
if [[ "${CI:-}" == "true" ]]; then
  # Temporarily disable PostgreSQL apt sources
  sudo find /etc/apt/sources.list.d -type f -name "*postgres*" -exec mv {} {}.disabled \;

  # Update package list without PostgreSQL repos
  if ! apt update; then
    echo "Warning: apt update had issues (excluding PostgreSQL repos)."
  fi

  # Re-enable PostgreSQL repos
  sudo find /etc/apt/sources.list.d -type f -name "*.disabled" -exec sh -c 'mv "$1" "${1%.disabled}"' _ {} \;

  # Install Python3 pip and pre-commit
  apt install -y python3-pip
  pip3 install pre-commit
else
  echo "Not in CI! Skipping installation of pre-commit. Please install it manually if executing this on your workstation"
fi
