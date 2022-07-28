title 'Tests to confirm binutil binaries work as expected'

plan_name = input('plan_name', value: 'binutils')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-binutils-binaries' do
  impact 1.0
  title 'Ensure binaries provided by binutils work as expected'
  desc '
  binutils bundles many binaries as part of its .hart file.
  In order to test these binaries we will first check that they exist and then
  run the binaries to check their version to verify they are working.
  '

  pkg_path = command("hab pkg path #{plan_ident}")
  describe pkg_path do
    its('stdout') { should_not be_empty }
    its('exit_status') { should eq 0 }
  end
  bin_directory = "#{pkg_path.stdout.strip}/bin/"

  binary_checks = %w(ld size elfedit readelf nm ranlib ar c++filt gprof as ld.bfd.real ld.bfd addr2line strip objdump objcopy strings dwp)

  binary_checks.each do |binary|
    describe file("#{File.join(bin_directory, binary)}") do
      it { should exist }
      its('size') { should > 0 }
      it { should be_executable }
    end
  end

  version = bin_directory.split('/')[5]

  binary_checks.each do |binary|
    describe command("#{File.join(bin_directory, binary)} --version") do
      its('stdout') { should match /\(GNU Binutils\) #{version}/ }
      its('exit_status') { should eq 0 }
    end
  end

  # ld.gold has a different version return format
  describe command("#{File.join(bin_directory, "ld.gold")} --version") do
    its('stdout') { should match /\(GNU Binutils #{version}\)/ }
    its('exit_status') { should eq 0 }
  end
end
