# -*- encoding: utf-8 -*-

require "ruby_scaffolding/gemfile_parser"

require "optparse"

module RubyScaffolding
  module Subcommand
    class Base
      def initialize(opts)
        @opts = opts
      end

      protected

      def parser_for_lockfile(lock)
        Dir.chdir(File.dirname(lock)) do
          parser = RubyScaffolding::GemfileParser.new(File.basename(lock))
          yield parser
        end
      end
    end

    class CompareGemVersion < Base
      def run
        lock = @opts[:lockfile]
        name = @opts[:gem_name]

        parser_for_lockfile(lock) do |parser|
          if ! parser.has_gem?(name)
            $stderr.puts "Gem '#{name}' not found in #{lock}"
            exit 10
          end

          ver = parser.gem_version(name)
          fail_msg = "Gem '#{name}' version #{ver} is"

          begin
            if @opts.key?(:eq) && ! (ver == @opts[:eq])
              raise "#{fail_msg} not equal to #{@opts[:eq]}"
            end
            if @opts.key?(:gt) && ! (ver > @opts[:gt])
              raise "#{fail_msg} not greater than #{@opts[:gt]}"
            end
            if @opts.key?(:gte) && ! (ver >= @opts[:gte])
              raise "#{fail_msg} not greater than or equal to #{@opts[:gte]}"
            end
            if @opts.key?(:lt) && ! (ver < @opts[:lt])
              raise "#{fail_msg} not less than #{@opts[:lt]}"
            end
            if @opts.key?(:lte) && ! (ver <= @opts[:lte])
              raise "#{fail_msg} not less than or equal to #{@opts[:lte]}"
            end
          rescue => e
            $stderr.puts e
            exit 20
          end
          puts "true"
        end
      end
    end

    class GemVersion < Base
      def run
        lock = @opts[:lockfile]
        name = @opts[:gem_name]

        parser_for_lockfile(lock) do |parser|
          if ! parser.has_gem?(name)
            $stderr.puts "Gem '#{name}' not found in #{lock}"
            exit 10
          end
          puts parser.gem_version(name)
        end
      end
    end

    class HasGem < Base
      def run
        lock = @opts[:lockfile]
        name = @opts[:gem_name]

        parser_for_lockfile(lock) do |parser|
          if parser.has_gem?(name)
            puts "true"
          else
            puts "false"
            exit 10
          end
        end
      end
    end

    class RubyVersion < Base
      def run
        lock = @opts[:lockfile]

        parser_for_lockfile(lock) do |parser|
          version = parser.ruby_version
          if !version.nil?
            puts version
          else
            $stderr.puts "No Ruby version found in #{lock}"
            exit 10
          end
        end
      end
    end
  end

  class CLI
    def self.run
      new.run
    end

    VERSION = "@version@"
    AUTHOR = "@author@"

    SUBCOMMANDS = {
      "compare-gem-version" => RubyScaffolding::Subcommand::CompareGemVersion,
      "gem-version" => RubyScaffolding::Subcommand::GemVersion,
      "has-gem" => RubyScaffolding::Subcommand::HasGem,
      "ruby-version" => RubyScaffolding::Subcommand::RubyVersion,
    }

    def initialize
      name = File.basename($0)
      @options = {}
      @global_parser = OptionParser.new do |opts|
        opts.banner = <<-_USAGE_
#{name} #{VERSION}

Authors: #{AUTHOR}

USAGE:
    #{name} [SUBCOMMAND]

FLAGS:
_USAGE_
        opts.on("-h", "--help", "Prints help information") do
          puts opts
          exit
        end
        opts.on("-V", "--version", "Prints version information") do
          puts "#{name} #{VERSION}"
          exit
        end
        opts.separator <<-_USAGE_

SUBCOMMANDS:
    compare-gem-version   Compares the version of a gem in a Gemfile.lock
    gem-version           Prints the version of a gem in a Gemfile.lock
    has-gem               Checks if a gem is present in a Gemfile.lock
    ruby-version          Prints the version of Ruby in a Gemfile.lock
_USAGE_
      end
      subcommand_parsers = {
        "compare-gem-version" => OptionParser.new do |opts|
          opts.banner = <<-_USAGE_
#{name}-compare-gem-version

Authors: #{AUTHOR}

USAGE:
    #{name} compare-gem-version [OPTIONS] <LOCKFILE> <GEM_NAME>

FLAGS:
    -h, --help       Prints help information

OPTIONS:
_USAGE_
        opts.on("--equal VERSION", "Equal to a version") do |v|
          @options[:eq] = Gem::Version.new(v)
        end
        opts.on("--greater-than VERSION", "Greater than a version") do |v|
          @options[:gt] = Gem::Version.new(v)
        end
        opts.on("--greater-than-eq VERSION", "Greater than or equal to a version") do |v|
          @options[:gte] = Gem::Version.new(v)
        end
        opts.on("--less-than VERSION", "Less than a version") do |v|
          @options[:lt] = Gem::Version.new(v)
        end
        opts.on("--less-than-eq VERSION", "Less than or equal to a version") do |v|
          @options[:lte] = Gem::Version.new(v)
        end
        opts.separator <<-_USAGE_

ARGS:
    <LOCKFILE>       The path to a Gemfile.lock (ex: ./Gemfile.lock)
    <GEM_NAME>       The gem name to look for (ex: rails)
_USAGE_
        end,
        "gem-version" => OptionParser.new do |opts|
          opts.banner = <<-_USAGE_
#{name}-gem-version

Authors: #{AUTHOR}

USAGE:
    #{name} gem-version <LOCKFILE> <GEM_NAME>

FLAGS:
    -h, --help       Prints help information

ARGS:
    <LOCKFILE>       The path to a Gemfile.lock (ex: ./Gemfile.lock)
    <GEM_NAME>       The gem name to look for (ex: rails)
_USAGE_
        end,
        "has-gem" => OptionParser.new do |opts|
          opts.banner = <<-_USAGE_
#{name}-has-gem

Authors: #{AUTHOR}

USAGE:
    #{name} has-gem <LOCKFILE> <GEM_NAME>

FLAGS:
    -h, --help       Prints help information

ARGS:
    <LOCKFILE>       The path to a Gemfile.lock (ex: ./Gemfile.lock)
    <GEM_NAME>       The gem name to look for (ex: rails)
_USAGE_
        end,
        "ruby-version" => OptionParser.new do |opts|
          opts.banner = <<-_USAGE_
#{name}-ruby-version

Authors: #{AUTHOR}

USAGE:
    #{name} ruby-version <LOCKFILE>

FLAGS:
    -h, --help       Prints help information

ARGS:
    <LOCKFILE>       The path to a Gemfile.lock (ex: ./Gemfile.lock)
_USAGE_
        end,
      }
      @global_parser.order!
      subcommand = ARGV.shift
      die("Subcommand required!") if subcommand.nil?
      subcommand_parsers.fetch(subcommand) {|key|
        die("Invalid subcommand: #{subcommand}")
      }.order!
      case subcommand
      when "compare-gem-version"
        @options[:lockfile] = ARGV.shift
        if @options[:lockfile].nil?
          die("Missing required: <LOCKFILE>", subcommand_parsers[subcommand])
        end
        @options[:gem_name] = ARGV.shift
        if @options[:gem_name].nil?
          die("Missing required: <GEM_NAME>", subcommand_parsers[subcommand])
        end
      when "gem-version"
        @options[:lockfile] = ARGV.shift
        if @options[:lockfile].nil?
          die("Missing required: <LOCKFILE>", subcommand_parsers[subcommand])
        end
        @options[:gem_name] = ARGV.shift
        if @options[:gem_name].nil?
          die("Missing required: <GEM_NAME>", subcommand_parsers[subcommand])
        end
      when "has-gem"
        @options[:lockfile] = ARGV.shift
        if @options[:lockfile].nil?
          die("Missing required: <LOCKFILE>", subcommand_parsers[subcommand])
        end
        @options[:gem_name] = ARGV.shift
        if @options[:gem_name].nil?
          die("Missing required: <GEM_NAME>", subcommand_parsers[subcommand])
        end
      when "ruby-version"
        @options[:lockfile] = ARGV.shift
        if @options[:lockfile].nil?
          die("Missing required: <LOCKFILE>", subcommand_parsers[subcommand])
        end
      end
      @subcommand_klass = SUBCOMMANDS.fetch(subcommand)
    end

    def run
      @subcommand_klass.new(@options).run
    end

    private

    attr_reader :options, :global_parser

    def die(msg, parser = global_parser)
      $stderr.puts msg
      $stderr.puts
      $stderr.puts parser
      exit 1
    end
  end
end
