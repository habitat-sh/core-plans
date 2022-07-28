title 'Tests to confirm gzip binaries works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "gzip")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-gzip-works' do
  impact 1.0
  title 'Ensure gzip binary is working as expected'
  desc '
  To test the binary that gzip provides, we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/gzip hooks/run
      gzip/hooks/run:   2.6% -- created gzip/hooks/run.gz
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  gzip_binary = File.join(hab_pkg_path.stdout.strip, base_dir, "gzip")

  gzip_version = command("#{gzip_binary} --version")
  describe gzip_version do
    its('stdout') { should match /gzip #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #run_file = File.join(hab_pkg_path.stdout.strip, "hooks/run")
  #run_file_gz = run_file + ".gz"

  # verbose output piped to stderr
  #gzip_works = command("#{gzip_binary} -fkv #{run_file} 2>&1")
  #describe gzip_works do
  #  its('stdout') { should match /#{run_file}:\s+[0-9]+.[0-9]+% -- created #{run_file_gz}/ }
  #  its('exit_status') { should eq 0 }
  #  describe file("#{run_file_gz}") do
  #    it { should exist }
  #  end
  #end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "bin")

  gunzip_works = command("#{File.join(bin_dir, "gunzip")} --version")
  describe gunzip_works do
    its('stdout') { should match /gunzip \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  gzexe_works = command("#{File.join(bin_dir, "gzexe")} --version")
  describe gzexe_works do
    its('stdout') { should match /gzexe \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  uncompress_works = command("#{File.join(bin_dir, "uncompress")} --version")
  describe uncompress_works do
    its('stdout') { should match /gunzip \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  zcat_works = command("#{File.join(bin_dir, "zcat")} --version")
  describe zcat_works do
    its('stdout') { should match /zcat \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  zcmp_works = command("#{File.join(bin_dir, "zcmp")} --version")
  describe zcmp_works do
    its('stdout') { should match /zcmp \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  zdiff_works = command("#{File.join(bin_dir, "zdiff")} --version")
  describe zdiff_works do
    its('stdout') { should match /zdiff \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #zegrep_works = command("#{File.join(bin_dir, "zegrep")} --version")
  #describe zegrep_works do
  #  its('stdout') { should match /zgrep \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  #zfgrep_works = command("#{File.join(bin_dir, "zfgrep")} --version")
  #describe zfgrep_works do
  #  its('stdout') { should match /zgrep \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  zforce_works = command("#{File.join(bin_dir, "zforce")} --version")
  describe zforce_works do
    its('stdout') { should match /zforce \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  #zgrep_works = command("#{File.join(bin_dir, "zgrep")} --version")
  #describe zgrep_works do
  #  its('stdout') { should match /zgrep \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end

  zless_works = command("#{File.join(bin_dir, "zless")} --version")
  describe zless_works do
    its('stdout') { should match /zless \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  zmore_works = command("#{File.join(bin_dir, "zmore")} --version")
  describe zmore_works do
    its('stdout') { should match /zmore \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  znew_works = command("#{File.join(bin_dir, "znew")} --version")
  describe znew_works do
    its('stdout') { should match /znew \(gzip\) #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
