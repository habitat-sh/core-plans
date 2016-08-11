#!/usr/bin/env ruby

require 'delegate'
require 'optparse'
require 'tsort'
require 'tempfile'

# Command line parser
class Cli
  def self.parse(argv) # rubocop:disable Metrics/MethodLength
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename(__FILE__)} <PKG_IDENT>"
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
      opts.separator ''
      opts.separator 'Examples:'
      opts.separator "    find . -name plan.sh | #{__FILE__} core/openssl"
    end
    parser.parse!(argv)
    if argv.size != 1
      abort parser.help
    end
    options[:pkg_ident] = argv.shift
    options
  end
end

# Dependency tracker.
class Sortable < SimpleDelegator
  include TSort

  def add(ident, deps = [])
    __getobj__[ident] = deps
  end

  def tsort_each_node(&block)
    __getobj__.each_key(&block)
  end

  def tsort_each_child(node, &block)
    __getobj__.fetch(node).each(&block)
  end
end

def dependents(pkg_ident, all_deps)
  dependents = []
  all_deps.each do |ident, deps|
    if deps.include?(pkg_ident)
      dependents << ident
    end
  end
  dependents
end

def process(pkg_ident, all_deps)
  results = dependents(pkg_ident, all_deps)
  return if results.empty?

  @rebuilds.concat(results)
  results.each { |pkg_ident| process(pkg_ident, all_deps) }
end

options = Cli.parse(ARGV)

bash_prog = Tempfile.new('print_deps.sh')
bash_prog.write(<<'EOF')
#!/bin/bash
set -e
STUDIO_TYPE=stage1
FIRST_PASS=true
PLAN_CONTEXT=$(pwd)/$(dirname $1)

cd $(dirname $1)
source $(basename $1)
echo "${pkg_origin}/${pkg_name}"
echo "${pkg_build_deps[*]} ${pkg_deps[*]}"
exit 0
EOF
bash_prog.close

all_deps = Sortable.new({})
ident_to_plan = {}

ARGF.each_line do |file|
  # Load the plan by sourcing it with a small Bash program
  raw = `bash #{bash_prog.path} #{file}`.chomp
  # Parse out the package identifier and the dependencies from the Bash program
  ident, _, deps_str = raw.partition(/\n/)
  # Add the package ident to a key in an "all deps" hash with the value being
  # an array of dependency package identifiers, but drop ourself so we
  # don't an infinitely recursive result set. This would happen if we
  # depend on a previous version of ourself, for example, `go`
  # requires `go` to build a newer `go`
  all_deps.add(ident, deps_str.split(' ')
    .map { |d| d.split('/').first(2).join('/') }
    .reject { |i| i == ident })
  # Add the pacakge ident to a key in a "plan" hash with the value being
  # the path to the directory containing the relevant `plan.sh`
  ident_to_plan[ident] = \
    file.chomp.sub(%r{/habitat/plan.sh$}, '').sub(%r{/plan.sh}, '')
end

# Iterate through every dependency array entry and add an entry into the "all
# deps" hash if it does not yet exist. This is done to ensure the topological
# sort will continue to completion.
all_deps.keys.each do |ident|
  all_deps[ident].each do |dep|
    all_deps.add(dep) unless all_deps.key?(dep)
  end
end

# Perform a topological sort of all dependencies to determine the full build
# ordering
sorted_deps = all_deps.tsort

# Set up a new array for all packages that will need to be rebuilt that take
# a depenendency on the given package ident
@rebuilds = []
# Build a coplete list of all direct dependent packages for the given package
# and # all direct dependent packages of each dependent package, etc, etc
process(options[:pkg_ident], all_deps)
# Ensure that the the array is a unique set
@rebuilds.uniq!

# Take the intersection of the topological sorted full package set and the
# unique packages to be rebuilt to yield a correct build order of all
# downstream dependent packages.
sorted_rebuilds = sorted_deps & @rebuilds

# Print out each dependent package
sorted_rebuilds.each do |ident|
  puts "#{ident} #{ident_to_plan[ident]}"
end
