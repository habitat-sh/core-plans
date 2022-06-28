title 'Tests to confirm libarchive binaries work as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libarchive")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libarchive' do
  impact 1.0
  title 'Ensure libarchive binaries are working as expected'
  desc '
  To test the binaries that libarchive provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists.
    $ $PKG_PATH/bin/bsdcat --version
      bsdcat 3.4.2 - libarchive 3.4.2 zlib/1.2.11 liblzma/5.2.4 bz2lib/1.0.8
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcat_exists = command("ls #{File.join(hab_pkg_path.stdout.strip, "/bin/bsdcat")}")
  describe bsdcat_exists do
    its('stdout') { should match /bsdcat/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcat_works = command("#{File.join(hab_pkg_path.stdout.strip, "/bin/bsdcat")} --version")
  describe bsdcat_works do
    its('stdout') { should match /bsdcat #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcpio_exists = command("ls #{File.join(hab_pkg_path.stdout.strip, "/bin/bsdcpio")}")
  describe bsdcpio_exists do
    its('stdout') { should match /bsdcpio/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdcpio_works = command("#{File.join(hab_pkg_path.stdout.strip, "/bin/bsdcpio")} --version")
  describe bsdcpio_works do
    its('stdout') { should match /bsdcpio #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdtar_exists = command("ls #{File.join(hab_pkg_path.stdout.strip, "/bin/bsdtar")}")
  describe bsdtar_exists do
    its('stdout') { should match /bsdtar/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bsdtar_works = command("#{File.join(hab_pkg_path.stdout.strip, "/bin/bsdtar")} --version")
  describe bsdtar_works do
    its('stdout') { should match /bsdtar #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
