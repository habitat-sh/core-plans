title 'Tests to confirm erlang20 works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'erlang20')

control 'core-plans-erlang20-works' do
  impact 1.0
  title 'Ensure erlang20 works as expected'
  desc '
  Verify erlang20 by ensuring that
  (1) its installation directory exists
  (2) erl returns the expected version
  (3) all other binaries, except for "escript" return expected "help" usage info
  (4) escript successfully runs an erlang "Hello World" script

  NOTE: testing all these binaries can be tricky: some use "--help" others
  use "-help"; some return output to stdout, other to stderr; some return "Usage:..."
  others return "usage:..."  The outcome is that no one standard test pattern can be
  used for all.  escript must reference an actual file; the normal linux <(..) re-direction
  does not work.
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  {
    "ct_run" => {
      command_output_pattern: /ct_run -dir TestDir1 TestDir2/,
      exit_pattern: /^[0]$/,
    },
    "dialyzer" => {
      command_suffix: "--help",
      exit_pattern: /^[0]$/,
    },
    "epmd" => {
    },
    "erl" => {
      command_suffix: "-eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), \"releases\", erlang:system_info(otp_release), \"OTP_VERSION\"])), io:fwrite(Version), halt().' -noshell",
      command_output_pattern: /#{plan_pkg_version}/,
      exit_pattern: /^[0]$/,
    },
    "erlc" => {
    },
    "escript" => {
      command_suffix: "",
      command_output_pattern: /Hello, World!/,
      exit_pattern: /^[0]$/,
      script: <<~END
        #!/usr/bin/env escript
        -export([main/1]).
        main([]) -> io:format("Hello, World!~n").
      END
    },
    "run_erl" => {
    },
    "to_erl" => {
    },
  }.each do |binary_name, value|
    # set default values if each binary_name doesn't define an over-ride
    command_suffix = value.has_key?(:command_suffix) ? "#{value[:command_suffix]} 2>\&1" : "-help 2>\&1"
    command_output_pattern = value[:command_output_pattern] || /[uU]sage:.+#{binary_name}/
    exit_pattern = value[:exit_pattern] || /^[^0]$/ # use /^[^0]$/ for non-zero exit status
    script = value[:script]

    # set default @command_under_test only adding a Tempfile if 'script' is defined
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    if(script)
      Tempfile.open('foo') do |f|
        f << script
        sleep(5) unless File.exists?(f.path)
        @command_under_test = command("#{command_full_path} #{f.path} #{command_suffix}")
      end
    else
        @command_under_test = command("#{command_full_path} #{command_suffix}")
    end

    # verify output
    describe @command_under_test do
      its('exit_status') { should cmp exit_pattern }
      its("stdout") { should match command_output_pattern }
    end
  end
end
