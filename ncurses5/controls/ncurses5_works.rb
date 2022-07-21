title 'Tests to confirm ncurses binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-ncurses' do
  impact 1.0
  title 'Ensure ncurses binary is working as expected'
  desc '
  To test the binaries that ncurses provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists or another similar simple test
    $ $PKG_PATH/bin/captoinfo -V
      ncurses 6.1.20180127 
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty } 
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  captoinfo_exists = command("ls -al #{File.join(target_dir, "captoinfo")}")
  describe captoinfo_exists do
    its('stdout') { should match /captoinfo/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  captoinfo_works = command("#{File.join(target_dir, "captoinfo")} -V")
  describe captoinfo_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  infocmp_exists = command("ls -al #{File.join(target_dir, "infocmp")}")
  describe infocmp_exists do
    its('stdout') { should match /infocmp/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  infocmp_works = command("#{File.join(target_dir, "infocmp")} -V")
  describe infocmp_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  ncursesw6_config_exists = command("ls -al #{File.join(target_dir, "ncursesw5-config")}")
  describe ncursesw6_config_exists do
    its('stdout') { should match /ncursesw5-config/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  ncursesw6_config_works = command("#{File.join(target_dir, "ncursesw5-config")} --version")
  describe ncursesw6_config_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tabs_exists = command("ls -al #{File.join(target_dir, "tabs")}")
  describe tabs_exists do
    its('stdout') { should match /tabs/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tabs_works = command("#{File.join(target_dir, "tabs")} -V")
  describe tabs_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  toe_exists = command("ls -al #{File.join(target_dir, "toe")}")
  describe toe_exists do
    its('stdout') { should match /toe/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  toe_works = command("#{File.join(target_dir, "toe")} -V")
  describe toe_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tset_exists = command("ls -al #{File.join(target_dir, "tset")}")
  describe tset_exists do
    its('stdout') { should match /tset/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tset_works = command("#{File.join(target_dir, "tset")} -V")
  describe tset_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  clear_exists = command("ls -al #{File.join(target_dir, "clear")}")
  describe clear_exists do
    its('stdout') { should match /clear/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  clear_works = command("#{File.join(target_dir, "clear")} -V")
  describe clear_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  infotocap_exists = command("ls -al #{File.join(target_dir, "infotocap")}")
  describe infotocap_exists do
    its('stdout') { should match /infotocap/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  infotocap_works = command("#{File.join(target_dir, "infotocap")} -V")
  describe infotocap_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  reset_exists = command("ls -al #{File.join(target_dir, "reset")}")
  describe reset_exists do
    its('stdout') { should match /reset/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  reset_works = command("#{File.join(target_dir, "reset")} -V")
  describe reset_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tic_exists = command("ls -al #{File.join(target_dir, "tic")}")
  describe tic_exists do
    its('stdout') { should match /tic/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tic_works = command("#{File.join(target_dir, "tic")} -V")
  describe tic_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tput_exists = command("ls -al #{File.join(target_dir, "tput")}")
  describe tput_exists do
    its('stdout') { should match /tput/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  tput_works = command("#{File.join(target_dir, "tput")} -V")
  describe tput_works do
    its('stdout') { should match /ncurses #{hab_pkg_path.stdout.strip.split('/')[5]}.[0-9]+/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
