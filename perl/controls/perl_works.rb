title 'Tests to confirm perl works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'perl')

control 'core-plans-perl-works' do
  impact 1.0
  title 'Ensure perl works as expected'
  desc '
  Verify perl by ensuring that
  (1) its installation directory exists
  (2) perl returns the expected version and functions correctly
  (3) instmodsh, json_pp, pl2pm function as expected
  (4) binaries return expected "usage" output.

  NOTE: Only verifying stdout or sterr matches on patterns,
  not also verifying exit_status, etc as the combinations get
  too complicated
  '

  # (1) installation directory exists
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end

  # (2) perl returns the expected version and functions correctly
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]
  [
    "perl",
    "perl#{plan_pkg_version}"
  ].each do |binary_name|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{command_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /This is perl 5.+\(v(?<version>#{plan_pkg_version})/ }
      #its('stderr') { should be_empty }
    end

    describe command("#{command_full_path} -e 'print \"Hello, World!\n\"'") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /Hello, World!/ }
      #its('stderr') { should be_empty }
    end
  end

  # (3) instmodsh and json_pp function as expected
  #   instmodsh requires 'q' from stdin to quit
  #   json_pp requires json input
  #   pl2pm returns expected warning for a missing file
  {
    "instmodsh" => {
      pattern: /List all installed modules/,
      command_prefix: "echo 'q' | ",
      command_suffix: "--help",
      io: "stdout",
    },
    "json_pp" => {
      pattern: /key => \"value\"/,
      command_prefix: "echo '{\"key\":\"value\"}' | ",
      command_suffix: "-f json -t dumper",
      io: "stdout",
    },
    "pl2pm" => {
      pattern: /Can't open file.that.does.not.exist: No such file or directory at \S+pl2pm line \d+/,
      command_suffix: "file.that.does.not.exist",
      io: "stderr",
    },
  }.each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{value[:command_prefix]} #{command_full_path} #{value[:command_suffix]}") do
      its(value[:io]) { should match value[:pattern] }
    end
  end

  # (4) binaries return expected 'usage' output
  {
    "corelist"    => {io: "stdout"},
    "cpan"        => {io: "stderr"},
    "enc2xs"      => {io: "stderr"},
    "encguess"    => {io: "stderr",},
    "h2xs"        => {io: "stderr"},
    "h2ph"        => {io: "stderr", command_prefix: "timeout 0.1s"},
    "libnetcfg"   => {io: "stderr"},
    "perldoc"     => {io: "stderr"},
    "perlivp"     => {io: "stdout"},
    "perlthanks"  => {io: "stdout"},
    "perlbug"     => {io: "stdout"},
    "piconv"      => {io: "stderr"},
    "pod2html"    => {io: "stderr"},
    "pod2man"     => {io: "stdout"},
    "pod2text"    => {io: "stdout"},
    "pod2usage"   => {io: "stdout"},
    "podchecker"  => {io: "stdout"},
    "prove"       => {io: "stdout"},
    "ptar"        => {io: "stderr"},
    "ptardiff"    => {io: "stderr"},
    "ptargrep"    => {io: "stdout"},
    "shasum"      => {io: "stdout"},
    "splain"      => {io: "stderr"},
    "xsubpp"      => {io: "stderr"},
    "zipdetails"  => {io: "stderr"},
  }.each do |binary_name, value|
    command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
    describe command("#{value[:command_prefix]} #{command_full_path} --help") do
      its(value[:io]) { should match /(([Uu]sage:\s+|[Uu]sage:\s+\S+)(?=#{binary_name})|#{binary_name}\s+\[)/ }
    end
  end

end
