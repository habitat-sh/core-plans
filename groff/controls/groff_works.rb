title 'Tests to ensure that binaries from groff work'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "groff")
plan_ident = "#{plan_origin}/#{plan_name}"

allow_list_v = input("allow_list_v")
allow_list_v_stderr = input("allow_list_v_stderr")
allow_list_version = input("allow_list_version")
block_list = input("block_list")

control 'core-plans-groff-works' do
  impact 1.0
  title 'Ensure groff binaries work as expected'
  desc '
  To test the binaries that groff binlinks work as expected we must first find the path to the binary.
  Once the path has been found, this control will loop through each of the working tests as defined in allow_lists & block_list.
  Each binary will have its version information displayed and tested for the correct version of groff.
    $ $PKG_PATH/bin/groff -v
      GNU groff version 1.22.4
Copyright (C) 2014 Free Software Foundation, Inc.
GNU groff comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of groff and its subprograms
under the terms of the GNU General Public License.
For more information about these matters, see the file
named COPYING.

called subprograms:

GNU grops (groff) version 1.22.4
GNU troff (groff) version 1.22.4
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end

  target_dir = File.join(hab_pkg_path.stdout.strip, base_dir)

  allow_list_v.each do | binary |
    describe command("hab pkg exec #{plan_ident} #{binary} -- -v") do
      its('stdout.strip') { should match /version #{hab_pkg_path.stdout.strip.split('/')[5]}/  }
      #its('stderr') { should eq '' }
      its('exit_status') { should eq 0 }
    end
  end

  allow_list_version.each do | binary |
    describe command("hab pkg exec #{plan_ident} #{binary} -- --version") do
      its('stdout.strip') { should match /version #{hab_pkg_path.stdout.strip.split('/')[5]}/  }
      #its('stderr') { should eq '' }
      its('exit_status') { should eq 0 }
    end
  end

  allow_list_v_stderr.each do | binary |
    describe command("hab pkg exec #{plan_ident} #{binary} -- -v") do
      its('stderr.strip') { should match /version #{hab_pkg_path.stdout.strip.split('/')[5]}/  }
      its('exit_status') { should eq 0 }
    end
  end

end
