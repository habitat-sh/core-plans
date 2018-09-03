# Chef Scaffolding for Habitat

This will take a Chef Policy file and will build it for use as a habitat service.

```bash
scaffold_policy_name=base
pkg_name=chef-policy-base
pkg_origin=adam
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"
```

Scaffolding expects `policyfiles` directory somewhere in projects directory tree. For example:

```
.
├── habitat
│   └── plan.sh
├── policyfiles
│   ├── base.lock.json
│   ├── base.rb
│   ├── test-policy.lock.json
│   └── test-policy.rb
└── test-cookbook
    ├── metadata.rb
    └── recipes
        └── default.rb
```

## Variables

* `scaffold_policy_name` - **Required**. Specify policy to use
* `scaffold_policy_group` - *Optional*. Set policy group in compile time. Default: `local`
* `scaffold_chef_client` - *Optional*. Override `Chef Client` package. Default: `chef/chef-client`
* `scaffold_chef_dk` - *Optional*. Override `Chef DK` package. Default `chef/chef-dk`

## Bundled Gems

This scaffolding allows you to bundle gems with a policy. Just install them in `$pkg_prefix` in `do_install` phase.
`$pkg_prefix` will be added to `GEM_PATH` environment variable automatically. Don't forget to call `do_default_install`:

```bash
scaffold_policy_name=test-policy
scaffold_policy_group=local
scaffold_chef_client=chef/chef-client
scaffold_chef_dk=chef/chef-dk

pkg_name=policy-test
pkg_origin=adam
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/gcc-libs
  core/curl
)

do_build_config() {
  do_default_build_config

  cat << EOF >> $pkg_prefix/config/client-config.rb

# Don't attempt reach any sources
clear_gem_sources true
rubygems_url []
EOF
  cat <<EOF >> $pkg_prefix/config/bootstrap-config.rb

# Don't attempt reach any sources
clear_gem_sources true
rubygems_url []
EOF
}

do_install() {
  do_default_install
  do_install_gems
}

do_install_gems() {
  # You're free to install any gems, dealing with native extensions, etc
  gem install mongo -v 2.6 -i $pkg_prefix
  gem install docker-api -v 1.34.0 -i $pkg_prefix
  gem install toml -i $pkg_prefix
}

```

## Offline Deployment

It is easily possible to create self-sufficient deployment archives with habitat and policies:

1. Implement application package with `habitat`
1. Write `Chef Cookbook` to manage your application
1. Write `Chef Policy` file
1. Add application packages into dependencies

```bash
scaffold_policy_name=myapp
scaffold_policy_group=prod
# scaffold_chef_client=chef/chef-client
# scaffold_chef_dk=chef/chef-dk

pkg_name=policy-myapp
pkg_origin=adam
pkg_version="1.1.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"

pkg_deps=(
  adam/myapp-database
  adam/myapp-web
  adam/myapp-loadbalancer
)

pkg_build_deps=(
  core/git
  core/make
  core/gcc
  core/gcc-libs
  core/curl
)

do_build_config() {
  do_default_build_config

  cat << EOF >> $pkg_prefix/config/client-config.rb

# Don't attempt reach any sources
clear_gem_sources true
rubygems_url []
EOF
  cat <<EOF >> $pkg_prefix/config/bootstrap-config.rb

# Don't attempt reach any sources
clear_gem_sources true
rubygems_url []
EOF
}

do_install() {
  do_default_install
  do_install_gems
}

do_install_gems() {
  # Required for the habitat cookbook
  gem install toml -i $pkg_prefix
}
```

Then export policy to a tar and install to a server:

```bash
# Locally
hab pkg export tar adam/policy-myapp

# Upload tar to a server and install with:
tar xf adam-policy-myapp-*.tar.gz -C /
cd $(/hab/bin/hab pkg path adam/policy-myapp)
/hab/bin/hab pkg exec adam/policy-myapp chef-client -z -c config/bootstrap-config.rb
```
