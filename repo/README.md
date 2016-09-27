# repo

Repo is a tool that [Google] built on top of Git. Repo helps
[Google] manage the many Git repositories, does the uploads to [Google's]
revision control system, and automates parts of the Android development
workflow.

## Usage

You need to export three environment variables in order to use `repo`:

```bash
GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
export GIT_SSL_CAINFO

SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
export SSL_CERT_FILE

PYTHONPATH="$(pkg_path_for core/python2)"
export PYTHONPATH
```

An example of how it can be used is shown below:

```bash
do_download() {
  GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export GIT_SSL_CAINFO
  build_line "Setting GIT_SSL_CAINFO=$GIT_SSL_CAINFO"

  export SSL_CERT_FILE="$GIT_SSL_CAINFO"
  build_line "Setting SSL_CERT_FILE=$SSL_CERT_FILE"

  PYTHONPATH="$(pkg_path_for core/python2)"
  export PYTHONPATH
  build_line "Setting PYTHONPATH=$PYTHONPATH"

  build_line "Setting up git username and email"
  git config --global user.email "your@emailaddress"
  git config --global user.name "devnull"

  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version"
  pushd "$HAB_CACHE_SRC_PATH/$pkg_name-$pkg_version"
  repo init -u "$pkg_source" --manifest-name="released/$pkg_version.xml"
  repo sync
  popd
}
```
