title 'Tests to confirm openjdk11 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'openjdk11')

control 'core-plans-openjdk11-works' do
  impact 1.0
  title 'Ensure openjdk11 works as expected'
  desc '
  Verify openjdk11 by ensuring that
  (1) its installation directory exists
  (2) all binaries, with exception of jconsole, return
      expected output: jconsole needs a jvm to connect to.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  fullsuite = {
    "jaotc" => {
      command_suffix: "",
    },
    "jar" => {
      command_suffix: "",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "jarsigner" => {},
    "java" => {},
    "javac" => {},
    "javadoc" => {
      command_suffix: "--",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "javap" => {},
    "jcmd" => {},
    # ignore because we need a JVM to connect to...
    # "jconsole" => {},
    "jdb" => {},
    "jdeprscan" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "jdeps" => {},
    "jhsdb" => {
      command_suffix: "--help",
      command_output_pattern: /clhsdb\s+command line debugger/,
    },
    "jimage" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "jinfo" => {
      command_suffix: "",
      exit_pattern: /^[^0]{1}\d*$/,
      command_output_pattern: /jinfo <option> <pid>/,
    },
    "jjs" => {
      command_output_pattern: /jjs \[<options>\] <files> \[-- <arguments>\]/,
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "jlink" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "jmap" => {},
    "jmod" => {},
    "jps" => {},
    "jrunscript" => {},
    "jshell" => {},
    "jstack" => {},
    "jstat" => {},
    "jstatd" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "keytool" => {
      command_output_pattern: /Key and Certificate Management Tool/,
    },
    "pack200" => {},
    "rmic" => {
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "rmid" => {
      command_suffix: "timeout 1",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "rmiregistry" => {
      command_suffix: "timeout 1",
      exit_pattern: /^[^0]{1}\d*$/,
    },
    "serialver" => {
      command_suffix: "",
      exit_pattern: /^[^0]{1}\d*$/,
      command_output_pattern: /use: serialver \[-classpath classpath\]/,
    },
    "unpack200" => {},
  }

  # Use the following to pull out a subset of the above and test progressively
  subset = fullsuite.select { |key, value| key.to_s.match(/^.*$/) }

  # over-ride the defaults below with (command_suffix:, io:, etc)
  subset.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>&1" : "-help 2>&1"
    command_output_pattern = value[:command_output_pattern] || /usage:(\s+|.*)#{binary_name}/i
    exit_pattern = value[:exit_pattern] || /^[0]$/ # use /^[^0]{1}\d*$/ for non-zero exit status

    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe bash("#{command_full_path} #{command_suffix}") do
      its('exit_status') { should cmp exit_pattern }
      its("stdout") { should match command_output_pattern }
    end
  end
end
