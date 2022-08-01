title 'Tests to confirm freetype-config works as expected'

plan_name = input('plan_name', value: 'freetype')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
freetype_config_version = input('fontconfig_version', value: '22.1.16')

control 'core-plans-freetype' do
  impact 1.0
  title 'Ensure freetype-config works'
  desc '
  To test freetype is present we check for the executable being present in the expected location.
  We then need to manually set the expected pkg_config_path for freetype.
  We also run the following to ensure freetype-config is functional:
    $ freetype-config --version
    22.1.16
  '

  freetype_pkg = command("hab pkg path #{plan_ident}")
  describe freetype_pkg do
    its('stdout') { should_not be_empty}
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  freetype_pkg = freetype_pkg.stdout.strip

  freetype_config_works = command("export PKG_CONFIG_PATH=#{freetype_pkg}/lib/pkgconfig/:$PKG_CONFIG_PATH && #{freetype_pkg}/bin/freetype-config --version")
  describe freetype_config_works do
    its('stdout') { should match /[0-9]+.[0-9]+.[0-9]+/ }
    its('exit_status') { should eq 0 }
  end

end
