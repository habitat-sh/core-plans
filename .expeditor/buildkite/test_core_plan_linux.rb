#!/usr/bin/env ruby
# frozen_string_literal: true
require 'Open3'
require 'optparse'

# Helper script to build and test any Habitat Core Plan

def show_run_cmd(cmd, header=nil)
  p "=====> #{header}" if header
  p "-> #{cmd}"
  # can explore other options here as needed e.g. adding a logger or improving the shell callout
  res = system(cmd)
  abort("Command '#{cmd}' failed with result '#{res}'") unless res
end

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: build_test_habitat_core_plan.rb [options]'
  opts.on('-p', '--package=PACKAGE', 'Local Habitat Core Package directory path to run against.') do |p|
    options[:package] = p
  end
end.parse!

package = options[:package]
abort("Package directory must be specified!") unless package
abort("Package directory #{package} is not a directory!") unless File.directory?(package)
abort("Package directory does not have InSpec config") unless File.file?(File.join(package, 'inspec.yml'))

prefix = "cd #{File.expand_path(package)} && "
show_run_cmd("#{prefix}hab pkg build .", header="Building package: #{package}")
show_run_cmd("#{prefix}. results/last_build.env && hab pkg export docker \"results/${pkg_artifact}\"", header="Exporting Docker image for package: #{package}")
show_run_cmd("#{prefix}. results/last_docker_export.env && docker run -d --name ${id} ${name}", header="Building package: #{package}")
show_run_cmd("#{prefix}. results/last_docker_export.env && until docker exec `docker ps -f name=${id} -q` /bin/hab svc status $name; do echo 'Waiting for successful package status...'; sleep 2; done", header='Checking Docker image is running OK')
show_run_cmd(". #{File.expand_path(package)}/results/last_docker_export.env && bundle exec inspec exec #{File.expand_path(package)} -t docker://`docker ps -f name=${id} -q` --attrs attributes.yml", header="Testing package with InSpec: #{package}")
