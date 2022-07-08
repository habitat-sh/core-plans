title 'Tests to confirm shadow works as expected'

plan_name = input('plan_name', value: 'shadow')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-shadow' do
  impact 1.0
  title 'Ensure shadow works'
  desc '
  Many binaries ship with shadow.  We check help information for a few of these e.g.

    $ chage -h
    Usage: chage [options] LOGIN
    ...

    $ useradd -h
    Usage: useradd [options] LOGIN

    $ passwd -h
    Usage: passwd [options] [LOGIN]
    ...
  '
  shadow_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe shadow_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  shadow_pkg_ident = shadow_pkg_ident.stdout.strip
  commands_to_test = %w(chage useradd passwd chgpasswd chpasswd chsh expiry
                        faillog gpasswd groupadd groupmems groupdel grpck userdel usermod)

  commands_to_test.each do |binary|
    describe file("#{File.join(shadow_pkg_ident, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  commands_to_test.each do |shadow_command|
    describe command("#{File.join(shadow_pkg_ident,'bin',shadow_command)} -h") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /Usage: #{shadow_command}/ }
      #its('stderr') { should be_empty }
    end
  end
end
