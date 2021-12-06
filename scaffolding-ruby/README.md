# Habitat Ruby Scaffolding

Ruby Scaffolding is a Habitat package which helps you build your Ruby-based **web applications**, **services**, and **processes** (hereafter referred to as "apps") into a package which runs consistently on a wide range of containers, virtual machines, or servers via the Habitat Supervisor. The Supervisor will facilitate clustering, discovery of database services, dynamically update configuration and credentials, coordinate reliable rolling updates, and a lot more!

* [Habitat Website](https://www.habitat.sh/)
* [Ruby Scaffolding Quickstart Guide](doc/quickstart.md)
* [Ruby Scaffolding Documentation](doc/reference.md)

## Troubleshooting

If you receive this error when running a build with this scaffolding:

# Small note before visiting this, a correction has been added, but this may be required in some extreme cases. 
# Please attempt running the scaffolding without this, and only use this as a last resort. 
```bash
The latest bundler is 1.15.4, but you are currently running 1.15.1.
To update, run `gem install bundler`
ERROR:  Could not find a valid gem '/hab/pkgs/core/bundler/1.15.1/20170621175238/cache/bundler-1.15.1
1.15.1.
bundler`.gem' (>= 0) in any repository
   widget_world: Build time: 0m41s
		widget_world: Exiting on error
```

You can bypass it by adding these lines to your plan.sh

```bash
do_prepare() {
    do_default_prepare
    _bundler_version="1.15.1"
}
```
