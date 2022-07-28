title 'Tests to confirm elixir works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'elixir')

control 'core-plans-elixir-works' do
  impact 1.0
  title 'Ensure elixir works as expected'
  desc '
  Verify elixir by ensuring that
  (1) its installation directory exists
  (2) its binaries return the expected version
  NOTE: "hab pkg exec core/elixir" MUST proceed all calls to
  the elixir binaries because they have runtime environment
  requirements.  For example, the locale must be set to UTF-8 and
  each must have access to the erlang "erl" executable.  For these
  reasons the following environment tests have also been added here
  (3) erl must be in the PATH
  (4) locale must be set to UTF-8
  '

  # (1) installation directory exists
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  # (2) binaries should return the correct version
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  [
    "elixir",
    "elixirc",
    "iex",
    "mix",
  ].each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("hab pkg exec #{plan_origin}/#{plan_name} -- #{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{plan_pkg_version}/ }
    end
  end

  # (3) erl must be on the $PATH
  root_path_of_erlang_binary = command("hab pkg path core/erlang")
  root_path_of_erlang_binary = root_path_of_erlang_binary.stdout.chomp!
  describe command("hab pkg exec #{plan_origin}/#{plan_name} which erl") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{root_path_of_erlang_binary}\/bin\/erl/ }
  end

  # (4) locale must be set to UTF-8
  describe command("hab pkg exec #{plan_origin}/#{plan_name} locale") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /LANG=en_US.UTF-8/ }
    its('stdout') { should match /LC_ALL=en_US.UTF-8/ }
  end
end
