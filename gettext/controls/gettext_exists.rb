title 'Tests to confirm gettext exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gettext')

control 'core-plans-gettext-exists' do
  impact 1.0
  title 'Ensure gettext exists'
  desc '
  Verify gettext by ensuring all binaries exist and are executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  [ "autopoint",
    "envsubst",
    "gettext",
    "gettext.sh",
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
    "ngettext",
    "recode-sr-latin",
    "xgettext"].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
    end
end
