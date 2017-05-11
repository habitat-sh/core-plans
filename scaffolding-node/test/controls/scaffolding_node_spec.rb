# encoding: utf-8
#
# Copyright: Copyright (c) 2017 Chef Software, Inc.
# License: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

title "Habitat Node.js Scaffolding"

hab = attribute(:hab,
  default: "/hab/bin/hab",
  description: "Path to hab binary (default is the location in a studio.)")
build = attribute(:build,
  default: "/hab/bin/build",
  description: "Command to build a Habitat package in a studio")
docco_command = attribute(:docco_command,
  default: "#{hab} pkg exec #{ENV['HAB_ORIGIN']}/docco docco",
  description: "Command to run docco")
examples_path = attribute(:examples_path,
  default: "/src/scaffolding-node/examples",
  description: "Path to examples")

control "local example" do
  # Since InSpec doesn't support nested describe blocks, and we want to make
  # multiple assertions here about different commands, just run build here instead
  # of in a `before` block.
  command("#{build} #{examples_path}/local").result

  describe command("#{docco_command} --version") do
    its(:stdout) { should eq "0.7.0\n" }
    its(:exit_status) { should eq 0 }
  end

  describe command("#{hab} pkg exec #{ENV['HAB_ORIGIN']}/local example") do
    its(:stdout) { should eq "example\n" }
    its(:exit_status) { should eq 0 }

    # TODO

    # These can't really work right now because name and version are required
    # in plans.
    it "parses the name from package.json into pkg_name"
    it "parses the version from package.json into pkg_version"

    # This probably works, but in a studio by default you don't have an SSH key
    # so it fails because it can't find that.
    it "works with node packages with git ssh urls as dependencies"

    # This could probably work, but engines lets you specify things like `node
    # >= 6.0`. We could probably do this by attempting to `hab install` or `hab pkg
    # search`, but even if it worked, you would be restricted to versions of node
    # that were published to the depot. Since we just include NPM with core/node, I
    # don't have any idea how you would make `npm ~1.0.20` work.
    it "parses the engines from package.json into pkg_deps=(core/node/$VERSION)"
    it "parses the node version from .nvmrc into pkg_deps=(core/node/$VERSION)"

    it "works with yarn"
  end

  describe command("#{hab} pkg exec #{ENV['HAB_ORIGIN']}/local another-example") do
    its(:stdout) { should eq "Another example\n" }
    its(:exit_status) { should eq 0 }
  end

  # The license from the manifest
  describe command("grep '^\* __License' $(#{hab} pkg path $HAB_ORIGIN/local)/MANIFEST") do
    its(:stdout) { should eq "* __License__: UNLICENSED \n" }
  end

  # This example contains an .nvmrc that should give us Node 5.6.0
  describe command("grep 'core\/node\/5\.6\.0' $(#{hab} pkg path $HAB_ORIGIN/local)/DEPS") do
    its("exit_status") { should eq 0 }
  end
end

control "local service with existing run hook example" do
  example = "local_service_existing_run_hook"
  command("#{build} #{examples_path}/#{example}").result

  run_hook_path = File.join(command(
    "#{hab} pkg path $HAB_ORIGIN/#{example}"
  ).stdout.chomp, "hooks/run")

  describe file(run_hook_path) do
    its(:content) { should eq "#!/bin/bash\ncat\n" }
  end

  # This example contains an both an .nvmrc and a scaffolding_node_pkg. The latter should win
  describe command("grep 'core\/node\/5\.6\.0' $(#{hab} pkg path $HAB_ORIGIN/#{example})/DEPS") do
    its("exit_status") { should eq 0 }
  end
end

control "local service with existing pkg_svc_run example" do
  example = "local_service_pkg_svc_run"
  command("#{build} #{examples_path}/#{example}").result

  run_hook_path = File.join(command(
    "#{hab} pkg path $HAB_ORIGIN/#{example}"
  ).stdout.chomp, "run")

  describe file(run_hook_path) do
    its("content") { should include("exec cat 2>&1") }
  end
end

control "local service with scripts.start set in package.json example" do
  command("#{build} #{examples_path}/local_service_npm_script").result

  run_hook_path = File.join(command(
    "#{hab} pkg path $HAB_ORIGIN/local_service_npm_script"
  ).stdout.chomp, "hooks/run")

  describe file(run_hook_path) do
    its("content") { should include("exec node custom.js 2>&1") }
  end
end

control "local service with existing server.js example" do
  command("#{build} #{examples_path}/local_service_server_js").result

  run_hook_path = File.join(command(
    "#{hab} pkg path $HAB_ORIGIN/local_service_server_js"
  ).stdout.chomp, "hooks/run")

  describe file(run_hook_path) do
    its("content") { should include("exec node server.js 2>&1") }
  end
end

control "pkg_source Git HTTPS example" do
  describe command("#{docco_command} --version") do
    before do
      command("#{build} #{examples_path}/pkg_source_git_https").result
    end

    its(:stdout) { should eq "0.7.0\n" }
    its(:exit_status) { should eq 0 }
  end

  # The pkg_description is the 2nd line of the manifest
  describe command("cat $(#{hab} pkg path $HAB_ORIGIN/docco)/MANIFEST | head -2 | tail -1") do
    its(:stdout) { should eq "The Quick and Dirty Literate Programming Documentation Generator\n" }
  end
end

control "pkg_source NPM Registry example" do
  describe command("#{docco_command} --version") do
    before do
      command("#{build} #{examples_path}/pkg_source_npm_registry").result
    end

    its(:stdout) { should eq "0.7.0\n" }
    its(:exit_status) { should eq 0 }
  end

  # The pkg_description is the 2nd line of the manifest
  describe command("cat $(#{hab} pkg path $HAB_ORIGIN/docco)/MANIFEST | head -2 | tail -1") do
    its(:stdout) { should eq "The Quick and Dirty Literate Programming Documentation Generator\n" }
  end

  # The maintainer from the manifest
  describe command("grep '^\* __Maintainer' $(#{hab} pkg path $HAB_ORIGIN/docco)/MANIFEST") do
    its(:stdout) { should eq "* __Maintainer__: jashkenas <jashkenas@gmail.com>\n" }
  end

  # The upstream URL from the manifest
  describe command("grep '^\* __Upstream URL' $(#{hab} pkg path $HAB_ORIGIN/docco)/MANIFEST") do
    its(:stdout) { should eq "* __Upstream URL__: [https://github.com/jashkenas/docco](https://github.com/jashkenas/docco)\n" }
  end

  # This example contains an both an a scaffolding_node_pkg. That should set the node version
  describe command("grep 'core\/node\/5\.6\.0' $(#{hab} pkg path $HAB_ORIGIN/local)/DEPS") do
    its("exit_status") { should eq 0 }
  end
end

control "pkg_source tarball example" do
  describe command("#{docco_command} --version") do
    before do
      command("#{build} #{examples_path}/pkg_source_tarball").result
    end

    its(:stdout) { should eq "0.7.0\n" }
    its(:exit_status) { should eq 0 }
  end
end
