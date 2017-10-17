# Habitat Node Scaffolding

Node Scaffolding is a Habitat package which helps you build your  [Node.js][node]-based **web applications**, **services**, and **processes** (hereafter referred to as "apps") into a package which runs consistently on a wide range of containers, virtual machines, or servers via the Habitat Supervisor. The Supervisor will facilitate clustering, discovery of external services such as databases, dynamically update configuration and credentials, coordinate reliable rolling updates, and a lot more!

* [Habitat Website](https://www.habitat.sh/)
* [Node Scaffolding Quickstart Guide](doc/quickstart.md)
* [Node Scaffolding Documentation](doc/reference.md)

# Pre-build, build, and post-build steps}

This scaffolding does support running build scripts, etc. that are defined in package.json. However, due to a [known issue](https://github.com/habitat-sh/habitat/issues/1547), you will need to run the Habitat services as "root" rather than the default "hab" user.  You can do this by adding this line to your plan.sh

```
pkg_svc_user=root
```

[node]: https://nodejs.org/en/
