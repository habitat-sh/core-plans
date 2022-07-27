title 'Tests to confirm libxml2 binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "libxml2")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-libxml2' do
  impact 1.0
  title 'Ensure libxml2 binary is working as expected'
  desc '
  To test the binaries that libxml2 provides we first check for the installation directory.
  Using this directory we then run checks to ensure the binary exists.
  Then we test that the version of the binary we expect to be installed exists or another similar simple test
    $ $PKG_PATH/bin/xml2-config --version
      2.9.10
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty}
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  libxml2_config_exists = command("ls -al #{File.join(target_dir, "xml2-config")}")
  describe libxml2_config_exists do
    its('stdout') { should match /xml2-config/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  xml2_config_works = command("#{File.join(target_dir, "xml2-config")} --version")
  describe xml2_config_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  xmlcatalog_exists = command("ls -al #{File.join(target_dir, "xmlcatalog")}")
  describe xmlcatalog_exists do
    its('stdout') { should match /xmlcatalog/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  xmlcatalog_works = command("#{File.join(target_dir, "xmlcatalog")} --create")
  describe xmlcatalog_works do
    its('stdout') { should match /DTD Entity Resolution XML Catalog V1.0/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  xmllint_exists = command("ls -al #{File.join(target_dir, "xmllint")}")
  describe xmllint_exists do
    its('stdout') { should match /xmllint/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  xmllint_works = command("#{File.join(target_dir, "xmllint")} --version")
  describe xmllint_works do
    its('stdout') { should be_empty }
    #its('stderr') { should match /\/bin\/xmllint: using libxml version [0-9]+/ }
    its('exit_status') { should eq 0 }
  end
end
