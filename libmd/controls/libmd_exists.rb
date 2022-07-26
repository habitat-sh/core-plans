title 'Tests to confirm libmd libraries exist'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libmd")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libmd' do
  impact 1.0
  title 'Ensure libmd libraries exist as expected'
  desc '
  In order to test that the libraries that libmd exist, we must first fine the package path.
  Using the package path we ensure that the directories that it is meant to create, have been created
    $ ls -al $PKG_PATH/include/
    total 48
drwxr-xr-x 2 root root 4096 Apr 16 08:08 .
drwxr-xr-x 6 root root 4096 Apr 16 08:08 ..
-rw-r--r-- 1 root root  764 Apr 16 08:08 md2.h
-rw-r--r-- 1 root root 1457 Apr 16 08:08 md4.h
-rw-r--r-- 1 root root 2002 Apr 16 08:08 md5.h
-rw-r--r-- 1 root root 1914 Apr 16 08:08 ripemd.h
-rw-r--r-- 1 root root 2353 Apr 16 08:08 rmd160.h
-rw-r--r-- 1 root root 1861 Apr 16 08:08 sha.h
-rw-r--r-- 1 root root 1786 Apr 16 08:08 sha1.h
-rw-r--r-- 1 root root 3958 Apr 16 08:08 sha2.h
-rw-r--r-- 1 root root 1851 Apr 16 08:08 sha256.h
-rw-r--r-- 1 root root 2118 Apr 16 08:08 sha512.h

  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "include")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "lib")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command("ls #{File.join(hab_pkg_path.stdout.strip, "share")}") do
    its('stdout') { should_not be_empty }
    #its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
