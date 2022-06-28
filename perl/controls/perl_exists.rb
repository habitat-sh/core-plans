title 'Tests to confirm perl exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'perl')

control 'core-plans-perl-exists' do
  impact 1.0
  title 'Ensure perl exists'
  desc '
  Verify perl by ensuring all binaries
  (1) exist and
  (2) are executable'

  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  [
    "corelist",
    "cpan",
    "enc2xs",
    "encguess",
    "h2ph",
    "h2xs",
    "instmodsh",
    "json_pp",
    "libnetcfg",
    "perl",
    "perl#{plan_pkg_version}",
    "perlbug",
    "perldoc",
    "perlivp",
    "perlthanks",
    "piconv",
    "pl2pm",
    "pod2html",
    "pod2man",
    "pod2text",
    "pod2usage",
    "podchecker",
    "prove",
    "ptar",
    "ptardiff",
    "ptargrep",
    "shasum",
    "splain",
    "xsubpp",
    "zipdetails",
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe file(command_full_path) do
      it { should exist }
      it { should be_executable }
    end
  end
end
