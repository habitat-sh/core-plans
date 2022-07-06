title 'Tests to confirm corretto11 issues have been fixed'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'corretto11')

control 'core-plans-corretto11-issue-001' do
  impact 1.0
  title 'Ensure patchelf successfully injects correct glibc linux library'
  desc '
  This control verifies that a recent issue https://github.com/chef-base-plans/corretto11/issues/1
  has in fact been fixed and achieves this by ensuring that
  (1) the installation is present
  (2) the expected linux library glibc ld-linux-x86-64.so.2 exists
  (3) all binaries have been patchelf-ed from something like 
      /lib64/ld-linux-x86-64.so.2, with exception of jconsole, orbd, to 
      the one located beneath core/glibc.  Note: only executable binaries
      should contain this link so some of the executables, which are ascii text
      shell scripts are treated differently; these are verified to be ascii not binary
  '
  
  # (1) the installation is present
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  # (2) The glibc linux library exists and should be readable
  glibc_installation_directory = command("hab pkg path core/glibc")
  describe glibc_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end 
  glibc_lib_file = File.join(glibc_installation_directory.stdout.strip, "lib", "ld-linux-x86-64.so.2")
  describe file(glibc_lib_file) do
    it { should exist }
    it { should be_readable }
  end


  # (3) all binaries point to the correct core/glibc library
  {
    "jaotc" => {},
    "jar" => {},
    "jarsigner" => {},
    "java" => {},
    "javac" => {},
    "javadoc" => {},
    "javap" => {},
    "jcmd" => {},
    "jconsole" => {},
    "jdb" => {},
    "jdeprscan" => {},
    "jdeps" => {},
    "jhsdb" => {},
    "jimage" => {},
    "jinfo" => {},
    "jjs" => {},
    "jlink" => {},
    "jmap" => {},
    "jmod" => {},
    "jps" => {},
    "jrunscript" => {},
    "jshell" => {},
    "jstack" => {},
    "jstat" => {},
    "jstatd" => {},
    "keytool" => {},
    "pack200" => {},
    "rmic" => {},
    "rmid" => {},
    "rmiregistry" => {},
    "serialver" => {},
    "unpack200" => {},
  }.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_prefix = value[:command_prefix] || "file"
    command_output_pattern = value[:command_output_pattern] || /#{glibc_lib_file.to_s}/ 
  
    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command( "#{command_prefix} #{command_full_path}") do
      its('exit_status') { should eq 0 }
      its("stdout") { should match command_output_pattern }
    end
  end
end