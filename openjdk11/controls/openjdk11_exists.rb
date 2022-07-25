title 'Tests to confirm openjdk11 exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'openjdk11')

control 'core-plans-openjdk11-exists' do
  impact 1.0
  title 'Ensure openjdk11 exists'
  desc '
  Verify openjdk11 by ensuring all binaries
  (1) exist and
  (2) are executable'

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
