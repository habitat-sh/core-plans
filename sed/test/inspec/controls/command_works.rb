pkg_ident = `grep pkg_ident results/last_build.env | cut -d \= -f2`.strip

control 'sed works and is the last built pkg_ident' do
  describe command('hab pkg exec core/sed sed --help') do
    its('stdout') { should match /Usage: .+#{pkg_ident}\/bin\/sed \[OPTION\]/ }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end

control 'Basic sed usage' do
  describe command('echo \'catcat\' | hab pkg exec core/sed sed \'s/cat/dog/g\'') do
    its('stdout') { should match /^dogdog$/ }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
