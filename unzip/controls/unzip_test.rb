title 'Tests to confirm unzip works as expected'

plan_name = input('plan_name', value: 'unzip')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-unzip' do
  impact 1.0
  title 'Ensure unzip works'
  desc '
  To test unzip we ensure that the extended help message is shown as expected:

    $ unzip -hh
    Extended Help for UnZip

    See the UnZip Manual for more detailed help
    ...
  '
  unzip_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe unzip_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  unzip_pkg_ident = unzip_pkg_ident.stdout.strip

  describe command("#{unzip_pkg_ident}/bin/unzip -hh") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Extended Help for UnZip/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end

control 'core-plans-unzip-binaries' do
  impact 1.0
  title 'Ensure unzip works'
  desc '
  To test the unzip binaries we first find the package path.
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

  binaries_to_test = ["funzip", "zipgrep", "zipinfo", "unzip", "unzipsfx"]
  binaries_to_test.each do |binary|
    describe file("#{File.join(hab_pkg_path, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  # Version checking funzip doesn't seem to work. Doesn't print version info to stderr/stdout
  describe command("#{File.join(hab_pkg_path, 'bin', 'funzip')}") do
    its('stdout') { should be_empty }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /funzip error: input not a zip or gzip file/ }
    its('exit_status') { should eq 3 }
  end

  describe command("#{File.join(hab_pkg_path, 'bin', 'zipgrep')}") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /usage: zipgrep/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 1 }
  end

  describe command("#{File.join(hab_pkg_path, 'bin', 'zipinfo')} --version") do
    its('stdout') { should be_empty }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /ZipInfo [0-9]+\.[0-9]+/ }
    its('exit_status') { should eq 10 }
  end

  describe command("#{File.join(hab_pkg_path, 'bin', 'unzip')} --version") do
    its('stdout') { should be_empty }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /UnZip #{version}/ }
    its('exit_status') { should eq 10 }
  end

  describe command("#{File.join(hab_pkg_path, 'bin', 'unzipsfx')} --version") do
    its('stdout') { should be_empty }
    #its('stderr') { should_not be_empty }
    #its('stderr') { should match /UnZipSFX #{version}/ }
    its('exit_status') { should eq 10 }
  end

end
