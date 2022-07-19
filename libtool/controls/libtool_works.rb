title 'Tests to confirm libtool works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'libtool')

control 'core-plans-libtool-works' do
  impact 1.0
  title 'Ensure libtool works as expected'
  desc '
  Verify libtool by ensuring that
  (1) installation directory should exist
  (2) binaries should return correct version
  (3) libtool --config should return non-empty text
  (4) libtool --config should contain all the above file and directory patterns
  (5a) all file patterns should exist on the system
  (5b) all directories should exist on the system'
  
  # (1) installation directory should exist
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end
  
  # (2) binaries should return correct version
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  [
    "libtool",
    "libtoolize"
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{binary_name} \(GNU libtool\) #{plan_pkg_version}/ }
      #its('stderr') { should be_empty }
    end
  end

  # (3) libtool --config should return non-empty text
  libtool_full_path = File.join(plan_installation_directory.stdout.strip, "bin", "libtool")
  libtool_config_output = command("#{libtool_full_path} --config")
  describe libtool_config_output do
    its('exit_status') { should eq 0 }
    #its('stderr') { should be_empty }
    its('stdout') { should_not be_empty }
  end

  # initialize file and directory patterns
  files = [
    /^GREP="(?<grep_binary_path>.+)"/,
    /^SED="(?<sed_binary_path>.+)"/,
    /^LD="(?<ld_binary_path>.+)"/,
    /NM="(?<nm_binary_path>[^\s]+).*"/,
    /lt_truncate_bin="(?<dd_binary_fullpath>[^\s]+)\s+bs.*"/
  ]
  directories = /LTCFLAGS="(?<ltcflags_include_directories>.+)"/
  
  # (4) libtool --config should contain all the above file and directory patterns
  all_patterns = files + [directories]
  all_patterns.each do |pattern|
    describe libtool_config_output do
      its('stdout') { should match pattern }
    end
  end

  # (5a) all file patterns should exist on the system
  files.each do |pattern|
    binary_fullpath = (libtool_config_output.stdout.match pattern)[1]
    describe file(binary_fullpath) do
      it { should exist }
    end
  end
  
  # (5b) all directories should exist on the system
  # ltcflags_directories = (libtool_config_output.stdout.match directories)[1]
  # ltcflags_directories.split(" ").each do|item|
  #   item.gsub!("-I","")
  #   describe file(item) do
  #     it { should exist }
  #   end
  # end
end
