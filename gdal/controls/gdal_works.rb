title 'Tests to confirm gdal works as expected'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gdal')

control 'core-plans-gdal-works' do
  impact 1.0
  title 'Ensure gdal works as expected'
  desc '
  Verify gdal by ensuring that
  (1) binary installation directory exists
  (2) all binaries (with some exceptions) return the expected version
  '
 
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
  describe plan_installation_directory do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
  end
 
  plan_pkg_version = plan_installation_directory.stdout.split("/")[5]

  # All return GDAL <version>
  [
    "gdal_grid",
    "gdal_rasterize",
    "gdal_translate",
    "gdaladdo",
    "gdalbuildvrt",
    "gdalenhance",
    "gdalinfo",
    "gdallocationinfo",
    "gdalmanage",
    "gdalserver",
    "gdalsrsinfo",
    "gdaltindex",
    "gdaltransform",
    "gdalwarp",
    "gnmanalyse",
    "gnmmanage",
    "nearblack",
    "ogr2ogr",
    "ogrinfo",
    "ogrlineref"
    ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe command("#{command_full_path} --version") do
        its('exit_status') { should eq 0 }
        its('stdout') { should_not be_empty }
        #its('stderr') { should be_empty }
        its('stdout') { should match /GDAL #{plan_pkg_version}/ }
      end
    end

  # only returns <version>
  gdal_config_full_path = File.join(plan_installation_directory.stdout.strip, "bin/gdal-config")
  describe command("#{gdal_config_full_path} --version") do
      its('exit_status') { should eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /#{plan_pkg_version}/ }
      #its('stderr') { should be_empty }
  end
  # returns <version> and sterr is not-empty
  gdal_contour_bull_path = File.join(plan_installation_directory.stdout.strip, "bin/gdal_contour")
  describe command("#{gdal_contour_bull_path} --version") do
      its('exit_status') { should_not eq 0 }
      its('stdout') { should_not be_empty }
      #its('stderr') { should_not be_empty }
      its('stdout') { should match /#{plan_pkg_version}/ }
  end
  # returns GDAL <version> and stderr is not-empty
  gdaldem_full_path = File.join(plan_installation_directory.stdout.strip, "bin/gdaldem")
  describe command("#{gdaldem_full_path} --version") do
      its('exit_status') { should_not eq 0 }
      its('stdout') { should_not be_empty }
      #its('stderr') { should_not be_empty }
      its('stdout') { should match /GDAL #{plan_pkg_version}/ }
  end
  # verify using --help not --version
  ogrtindex_full_path = File.join(plan_installation_directory.stdout.strip, "bin/ogrtindex")
  describe command("#{ogrtindex_full_path} --help") do
      its('exit_status') { should_not eq 0 }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /Usage: ogrtindex/ }
      #its('stderr') { should be_empty }
  end
  # verify without any options
  testepsg_full_path = File.join(plan_installation_directory.stdout.strip, "bin/testepsg")
  describe command("#{testepsg_full_path}") do
      its('exit_status') { should eq 0 }
      #its('stderr') { should be_empty }
      its('stdout') { should_not be_empty }
      its('stdout') { should match /testepsg \[-xml\]/ }
  end
end
