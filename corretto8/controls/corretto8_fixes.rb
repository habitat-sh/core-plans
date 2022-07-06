title 'Tests to confirm corretto8 issues have been fixed'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'corretto8')

control 'core-plans-corretto8-issue-001' do
  impact 1.0
  title 'Ensure patchelf successfully injects correct glibc linux library'
  desc '
  This control verifies that a recent issue https://github.com/chef-base-plans/corretto8/issues/1
  has in fact been fixed and achieves this by ensuring that
  (1) the installation is present
  (2) the expected linux library glibc ld-linux-x86-64.so.2 exists
  (3) all binaries have been patchelf-ed from something like 
      /lib64/ld-linux-x86-64.so.2, with exception of jconsole, orbd, to 
      the one located beneath core/glibc.  Note: only executable binaries
      should contain this link so some of the executables, which are ascii text
      shell scripts are treated differently; these are verified to be ascii not binary
  (4) all jre binaries have likewise been patched
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
    "appletviewer" => {},
    "extcheck" => {},
    "idlj" => {},
    "jar" => {},
    "jarsigner" => {},
    "java" => {},
    "java-rmi.cgi" => {
      command_output_pattern: /POSIX shell script, ASCII text executable/,
    },
    "javac" => {},
    "javadoc" => {},
    "javafxpackager" => {
      command_output_pattern: /POSIX shell script, ASCII text executable/,
    },
    "javah" => {},
    "javap" => {},
    "javapackager" => {
      command_output_pattern: /POSIX shell script, ASCII text executable/,
    },
    "jcmd" => {},
    "jconsole" => {},
    "jdb" => {},
    "jdeps" => {},
    "jhat" => {},
    "jinfo" => {},
    "jjs" => {},
    "jmap" => {},
    "jps" => {},
    "jrunscript" => {},
    "jsadebugd" => {},
    "jstack" => {},
    "jstat" => {},
    "jstatd" => {},
    "keytool" => {},
    "native2ascii" => {},
    "orbd" => {},
    "pack200" => {},
    "policytool" => {},
    "rmic" => {},
    "rmid" => {},
    "rmiregistry" => {},
    "schemagen" => {},
    "serialver" => {},
    "servertool" => {},
    "tnameserv" => {},
    "unpack200" => {},
    "wsgen" => {},
    "wsimport" => {},
    "xjc" => {},
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

  # (4) all jre binaries point to the correct core/glibc library
  {
    "java" => {},
    "jjs" => {},
    "keytool" => {},
    "orbd" => {},
    "pack200" => {},
    "policytool" => {},
    "rmid" => {},
    "rmiregistry" => {},
    "servertool" => {},
    "tnameserv" => {},
    "unpack200" => {},
  }.each do |binary_name, value|
    # set default values if each binary doesn't define an over-ride
    command_prefix = value[:command_prefix] || "file"
    command_output_pattern = value[:command_output_pattern] || /#{glibc_lib_file.to_s}/ 
  
    # verify output
    command_full_path = File.join(plan_installation_directory.stdout.strip, "jre", "bin", binary_name)
    describe command( "#{command_prefix} #{command_full_path}") do
      its('exit_status') { should eq 0 }
      its("stdout") { should match command_output_pattern }
    end
  end
end
