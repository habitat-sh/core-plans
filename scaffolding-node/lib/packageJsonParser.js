// This script takes the path to a package.json and a Habitat plan variable
// name (such as pkg_description or pkg_bin_dirs) as arguments, parses the
// package.json, and outputs the value that variable should use, so:
//
//    node packageJsonParser.js $CACHE_PATH/package.json pkg_description
//
// should output the description from the package.json.
//
// It is intended to be used in the node.js scaffolding.

var values = {
  pkg_description: function () {
    return packageJson.description;
  },

  pkg_license: function () {
    return packageJson.license;
  },

  pkg_maintainer: function () {
    if (packageJson.maintainers) {
      return packageJson.maintainers.join(" ").trim();
    } else {
      return packageJson.maintainers;
    }
  },

  pkg_name: function () {
    return packageJson.name;
  },

  pkg_svc_run: function () {
    if ("scripts" in packageJson && "start" in packageJson.scripts) {
      return packageJson.scripts.start;
    }
  },

  pkg_upstream_url: function () {
    return packageJson.homepage;
  }
};

var packageJson = require(process.argv[2]);
console.log(values[process.argv[3]]() || "");
