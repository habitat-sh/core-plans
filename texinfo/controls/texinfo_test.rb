title 'Tests to confirm texinfo works as expected'

plan_name = input('plan_name', value: 'texinfo')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-texinfo' do
  impact 1.0
  title 'Ensure texinfo works'
  desc '
  There are several binaries in the texinfo package.  We check that the binary is executable and version commands succeed
  '
  
  texinfo_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe texinfo_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  texinfo_pkg_ident = texinfo_pkg_ident.stdout.strip
  version_string = texinfo_pkg_ident.split('/')[5]

  binaries_to_test = %w(info makeinfo texi2dvi texi2pdf pod2texi pdftexi2dvi install-info texi2any texindex)
  binaries_to_test.each do |binary|
    describe file("#{File.join(texinfo_pkg_ident, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  binaries_to_test = ["info", "install-info", "texi2any"]
  binaries_to_test.each do |binary|
    describe command("#{File.join(texinfo_pkg_ident, 'bin', binary)} --version") do
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{binary} \(GNU texinfo\) #{version_string}/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

  binaries_to_test = ["texi2pdf", "pdftexi2dvi"]
  binaries_to_test.each do |binary|
    describe command("#{File.join(texinfo_pkg_ident, 'bin', binary)} --version") do
      its('stdout') { should_not be_empty }
      its('stdout') { should match /texi2pdf \(GNU Texinfo #{version_string}\)/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

  describe command("#{File.join(texinfo_pkg_ident, 'bin', 'texi2dvi')} --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /texi2dvi \(GNU Texinfo #{version_string}\)/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{File.join(texinfo_pkg_ident, 'bin', 'makeinfo')} --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /texi2any \(GNU texinfo\) #{version_string}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("#{File.join(texinfo_pkg_ident, 'bin', 'pod2texi')} --version") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /pod2texi [0-9]+\.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
