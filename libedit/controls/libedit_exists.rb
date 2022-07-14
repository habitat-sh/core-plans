title 'Tests to confirm libedit libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libedit")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libedit' do
  impact 1.0
  title 'Ensure libedit libraries exist as expected'
  desc '
  To test libedit libraries exists we check for the path of the installed package.
  Then we check that the library exists in the expected location.  
    $ ls -al $PKG_PATH/include
       
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls -al #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
