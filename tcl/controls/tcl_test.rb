title 'Tests to confirm tcl works as expected'

plan_name = input('plan_name', value: 'tcl')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-tcl' do
  impact 1.0
  title 'Ensure tcl works'
  desc '
  To test TCL we borrow a nice one-liner from here: https://wiki.tcl-lang.org/page/One+Liners

    $ echo "puts [string map {a { P} b { a} c { c} d { T} e ck f cl g ha h od i th j {l } k no l {g } m in n Ju o st p er} nobkipapjgepchmlmdf]" | tclsh
    Just another Perl hacker coding in Tcl
  '
  tcl_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe tcl_pkg_ident do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  tcl_pkg_ident = tcl_pkg_ident.stdout.strip

  describe command("echo \"puts [string map {a { P} b { a} c { c} d { T} e ck f cl g ha h od i th j {l } k no l {g } m in n Ju o st p er} nobkipapjgepchmlmdf]\" | #{tcl_pkg_ident}/bin/tclsh") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Just another Perl hacker coding in Tcl/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  describe command("echo \"puts [string map {a { P} b { a} c { c} d { T} e ck f cl g ha h od i th j {
l } k no l {g } m in n Ju o st p er} nobkipapjgepchmlmdf]\" | #{tcl_pkg_ident}/bin/tclsh8.6") do
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Just another Per\nl hacker coding in Tcl\n/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
end

control 'core-plans-tcl-binaries' do
  impact 1.0
  title 'Ensure binaries work'
  desc '
  To test other binaries that tcl provides we first get the path to the package.
  Using this path we check that the binaries exist and are executable.
  We then execute the binaries to check their functionality.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  hab_pkg_path = hab_pkg_path.stdout.strip

  binaries_to_test = %w(tclsh8.6 tclsh) #sqlite3_analyzer)
  binaries_to_test.each do |binary|
    describe file("#{File.join(hab_pkg_path, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  #describe command("#{File.join(hab_pkg_path, 'bin', "sqlite3_analyzer")} --version") do
  #  its('stdout') { should_not be_empty }
  #  its('stdout') { should match /[0-9]+\.[0-9]+\.[0-9]+/ }
  #  #its('stderr') { should be_empty }
  #  its('exit_status') { should eq 0 }
  #end
end
