title 'Tests to confirm libevent works as expected'

plan_name = input('plan_name', value: 'libevent')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-libevent' do
  impact 1.0
  title 'Ensure libevent is correct'
  desc '
  For libevent we check for the presence of a couple of files to ensure the package is
  correctly installed:  lib/libevent.so and bin/event_rpcgen.py.
  '
  libevent_pkg = command("#{hab_path} pkg path #{plan_ident}")
  describe libevent_pkg do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  libevent_pkg = libevent_pkg.stdout.strip

  describe command("ls -al #{libevent_pkg}/lib/libevent.so") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{libevent_pkg}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{libevent_pkg}/bin/event_rpcgen.py") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /#{libevent_pkg}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
