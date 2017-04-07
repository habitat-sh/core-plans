# Python Scaffolding

## Getting Started with Scaffolding
See https://www.habitat.sh/docs/concepts-scaffolding/ to learn how to get started with Scaffolding.

## Variables
| Variable | Type | Value | Default |
| -------- | ---- | ----- | ------- |
|`pkg_scaffolding_python_runtime_pkg_name`| **String** | (Optional) Origin and Package Name for Python package which is used for runtime (pkg_deps). | `"core/python"` |
|`pkg_scaffolding_python_pip_name`| **String** | (Optional) Name of package on pypi which can differ from the hab package name.| `"$pkg_name"` |
|`pkg_scaffolding_python_pip_version`| **String** | (Optional) Version of package on pypy which can differen from hab package version.| `"$pkg_version"` |
|`pkg_scaffolding_python_virtualenv_cmd`| **String** | (Optional) Base command to execute for the python virtual env. | `"python -m virtualenv"` |

## Callbacks
### Scaffolding
#### scaffolding_python_clean
If a `setup.py` is found, it attemtps to performs `python setup.py clean --all` to recursively clean the compiled byte code. If one is not found, it will run a find and delete all `*.pyc` and `*.pyo` files.

#### scaffolding_python_build
This makes multiple calls.

1. Calls `scaffolding_python_virtualenv` to create a virtualenv with symlinks to the python interpreter.
2. It will attempt to use a `setup.py` and if one is found it will run `scaffolding_python_setuptools_install`. If a `setup.py` is not found this will `return 0` as there is nothing to build.

#### scaffolding_python_prepare
The default behavior of this callback is to attempt to set the values of `pkg_description` and `pkg_upstream_url` to the values defined in `setup.py` should one be available.

#### scaffolding_python_install
Installs the application into `$pkg_prefix.`

If a `setup.py` is found, this will call `scaffolding_python_setuptools_install`. If `setup.py` is not found otherwise it will call `scaffolding_python_pip_install` will run against `$pkg_name` and `$pkg_version`. The package name and version on pip can differ from the habitat package name and version, and an override can be specified via the `pkg_scaffolding_python_pip_name` and `pkg_scaffolding_python_pip_version` variables.

#### scaffolding_python_virtualenv
Installs the virtualenv python package into the site-packages of the python build dependecy if needed, then creates a virtualenv for the package. This is automatically called for all installs to ensure the interpreter is set correctly.

#### scaffolding_python_pip_install
Installs packages via pip, and accepts three input parameters.
 1. Package name on pypi.
 2. Package version on pypi.
 3. (Optional) Arguments to pass to pip. Defaults to: "--prefix=$pkg_prefix --force-reinstall --no-compile"
#### scaffolding_python_setuptools_install
Builds and installs packages via `setup.py` into a virtualenv. The virtualenv is used to provide a relative path to python and the PYTHONPATH for the installation.

#### scaffolding_python_strip
Calls `do_default_strip` and then `scaffolding_python_clean`.

### Default Overrides
The following default callbacks have overrides:
* `do_default_download`Calls [scaffolding_python_download](#scaffolding_python_download)
* `do_default_clean` - Calls [scaffolding_python_clean](#scaffolding_python_clean)
* `do_default_verify` - NOP -- Returns 0
* `do_default_unpack` - NOP -- Returns 0
* `do_default_prepare` - Calls [scaffolding_python_prepare](#scaffolding_python_prepare)
* `do_default_build`- Calls [scaffolding_python_build](#scaffolding_python_build)
* `do_default_install` - Calls [scaffolding_python_install](#scaffolding_python_install)
