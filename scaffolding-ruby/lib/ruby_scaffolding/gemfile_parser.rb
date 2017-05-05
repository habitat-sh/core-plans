# -*- encoding: utf-8 -*-

require "bundler"
require "bundler/definition"
require "bundler/lockfile_parser"
require "pathname"

module RubyScaffolding
  class GemfileParser
    def initialize(lockfile_path)
      @lockfile_path = Pathname(lockfile_path)
      if !@lockfile_path.file?
        raise "Lockfile not found: #{@lockfile_path}"
      end
    end

    def ruby_version
      version = locked_gems.ruby_version
      version && version.sub(/p\d+/, "")
    end

    def has_gem?(name)
      specs.key?(name)
    end

    def gem_version(name)
      specs.fetch(name).version
    end

    private

    def locked_gems
      @locked_gems ||= begin
        contents = Bundler.read_file(@lockfile_path)
        Bundler::LockfileParser.new(contents)
      end
    end

    def specs
      @specs ||= locked_gems.specs.
        each_with_object({}) { |spec, hash| hash[spec.name] = spec }
    end
  end
end
