title 'Tests to confirm xz-musl works as expected'

plan_name = input('plan_name', value: 'xz-musl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-xz-musl' do
  impact 1.0
  title 'Ensure xz-musl works'
  desc '
  For xz-musl we check that the version is correctly returned e.g.

    $ xz --version
    xz (XZ Utils) 5.2.5
    liblzma 5.2.5
  '
  xz_musl_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe xz_musl_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  xz_musl_pkg_ident = xz_musl_pkg_ident.stdout.strip

  describe command("#{xz_musl_pkg_ident}/bin/xz --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /xz \(XZ Utils\)\s+#{xz_musl_pkg_ident.split('/')[5]}/ }
    #its('stderr') { should be_empty }
  end
end

control 'core-plans-xz-musl-binaries' do
  impact 1.0
  title 'Ensure xz-musl works'
  desc '
  To test the xz-musl binaries we first find the package path.
  Using the package path to locate the binaries, we check that they exist and are executable.
  Then we run version checks on them to prove that they work.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  hab_pkg_path = hab_pkg_path.stdout.strip
  version = hab_pkg_path.split('/')[5]

  binaries_to_test = command("ls #{File.join(hab_pkg_path, 'bin')}")
  describe binaries_to_test do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  binaries_to_test = binaries_to_test.stdout.strip.split().to_a

  binaries_to_test.each do |binary|
    describe file("#{File.join(hab_pkg_path, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  # Introducing specificity introduces errors.
  binaries_to_test.each do |binary|
    describe command("#{File.join(hab_pkg_path, 'bin', binary)} --version") do
      its('stdout') { should match /#{version}/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end
end
