title 'Tests to confirm gettext works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gettext')

control 'core-plans-gettext-works' do
  impact 1.0
  title 'Ensure gettext works as expected'
  desc '
  Verify gettext by ensuring that
  (1) its installation directory exists
  (2) the gettext-runtime binaries return the expected version
  (3) the gettext-tools binaries return the expected version
  '

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]

  # (GNU gettext-runtime)
  ["envsubst",
  "gettext",
  "gettext.sh",
  "ngettext"].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
        its('exit_status') { should eq 0 }
        its('stdout') { should_not be_empty }
        its('stdout') { should match /#{binary_name} \(GNU gettext-runtime\) #{plan_pkg_version}/ }
        #its('stderr') { should be_empty }
    end
  end

  # (GNU gettext-tools)
  [ "autopoint",
  "gettextize",
  "msgattrib",
  "msgcat",
  "msgcmp",
  "msgcomm",
  "msgconv",
  "msgen",
  "msgexec",
  "msgfilter",
  "msgfmt",
  "msggrep",
  "msginit",
  "msgmerge",
  "msgunfmt",
  "msguniq",
  "recode-sr-latin",
  "xgettext"].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
        its('exit_status') { should eq 0 }
        its('stdout') { should_not be_empty }
        its('stdout') { should match /#{binary_name} \(GNU gettext-tools\) #{plan_pkg_version}/ }
        #its('stderr') { should be_empty }
    end
  end
end
