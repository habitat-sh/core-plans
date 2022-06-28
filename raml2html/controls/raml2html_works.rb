title 'Tests to confirm raml2html binary works as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "raml2html")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-raml2html' do
  impact 1.0
  title 'Ensure raml2html works'
  desc '
  To test raml2html is present we check for the executable being present in the expected location.
  We also run the following to ensure freetype-config is functional:
    $ raml2html --version
    6.3.0
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  raml2html_exists = command("ls #{File.join(target_dir, "raml2html")}")
  describe raml2html_exists do
    its('stdout') { should match /raml2html/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  raml2html_works = command("#{File.join(target_dir, "raml2html")} --version")
  describe raml2html_works do
    its('stdout') { should match /#{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end
