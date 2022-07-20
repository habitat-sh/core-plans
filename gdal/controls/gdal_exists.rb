title 'Tests to confirm gdal exists'

plan_origin = ENV['HAB_ORIGIN']
plan_name = input('plan_name', value: 'gdal')

control 'core-plans-gdal-exists' do
  impact 1.0
  title 'Ensure gdal exists'
  desc '
  Verify gdal by ensuring all binaries
  (1) exist
  (2) are executable'
 
  plan_installation_directory = command("hab pkg path #{plan_origin}/#{plan_name}")
 
  [ "gdal-config",
    "gdal_contour",
    "gdal_grid",
    "gdal_rasterize",
    "gdal_translate",
    "gdaladdo",
    "gdalbuildvrt",
    "gdaldem",
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
    "ogrlineref",
    "ogrtindex",
    "testepsg",
    ].each do |binary_name|
      command_full_path = File.join(plan_installation_directory.stdout.strip, "bin", binary_name)
      describe file(command_full_path) do
        it { should exist }
        it { should be_executable }
      end
    end
end
