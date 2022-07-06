title 'Tests to confirm corretto11 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'corretto11')

control 'core-plans-corretto11-exists' do
  impact 1.0
  title 'Ensure corretto11 exists'
  desc '
  Verify corretto11 by ensuring bin/java 
  (1) exists and
  (2) is executable'
  
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  [
  "jaotc",
  "jar",
  "jarsigner",
  "java",
  "javac",
  "javadoc",
  "javap",
  "jcmd",
  "jconsole",
  "jdb",
  "jdeprscan",
  "jdeps",
  "jhsdb",
  "jimage",
  "jinfo",
  "jjs",
  "jlink",
  "jmap",
  "jmod",
  "jps",
  "jrunscript",
  "jshell",
  "jstack",
  "jstat",
  "jstatd",
  "keytool",
  "pack200",
  "rmic",
  "rmid",
  "rmiregistry",
  "serialver",
  "unpack200",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
