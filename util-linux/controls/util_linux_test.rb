title 'Tests to confirm util-linux works as expected'

plan_name = input('plan_name', value: 'util-linux')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'core-plans-util-linux' do
  impact 1.0
  title 'Ensure util-linux works'
  desc '
  util-linux contains a large number of binary executables.  We perform basic operations with
  several of these to ensure the package is working correctly.

    $ uuidgen --sha1 --namespace @dns --name "www.example.com"
    2ed6657d-e927-568b-95e1-2665a8aea6a2

    $ whereis uuidgen
    uuidgen: /hab/pkgs/core/util-linux/2.34/20200306003119/bin/uuidgen

    $ look --version
    look from util-linux 2.34

    $ cal -y
                                   2020

           January               February                 March
    Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
              1  2  3  4                      1    1  2  3  4  5  6  7
     5  6  7  8  9 10 11    2  3  4  5  6  7  8    8  9 10 11 12 13 14
    12 13 14 15 16 17 18    9 10 11 12 13 14 15   15 16 17 18 19 20 21
    19 20 21 22 23 24 25   16 17 18 19 20 21 22   22 23 24 25 26 27 28
    26 27 28 29 30 31      23 24 25 26 27 28 29   29 30 31
    ...

    $ lscpu
    Architecture:                    x86_64
    CPU op-mode(s):                  32-bit, 64-bit
    Byte Order:                      Little Endian
    Address sizes:                   39 bits physical, 48 bits virtual
    CPU(s):                          4
    ...

    $ lsmem
    RANGE                                  SIZE  STATE REMOVABLE BLOCK
    0x0000000000000000-0x000000009fffffff  2.5G online        no  0-19
    0x00000000a0000000-0x00000000b7ffffff  384M online       yes 20-22
    ...
  '
  util_linux_pkg_ident = command("#{hab_path} pkg path #{plan_ident}")
  describe util_linux_pkg_ident do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  util_linux_pkg_ident = util_linux_pkg_ident.stdout.strip

  describe command("#{util_linux_pkg_ident}/bin/whereis uuidgen") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /bin\/uuidgen/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{util_linux_pkg_ident}/bin/uuidgen --sha1 --namespace @dns --name 'www.example.com'") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /2ed6657d-e927-568b-95e1-2665a8aea6a2/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{util_linux_pkg_ident}/bin/look --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /look from util-linux #{util_linux_pkg_ident.split('/')[5]}/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{util_linux_pkg_ident}/bin/cal -y") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /August/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{util_linux_pkg_ident}/bin/lscpu") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /CPU/ }
    #its('stderr') { should be_empty }
  end

  describe command("#{util_linux_pkg_ident}/bin/lsmem") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /Memory block size/ }
    #its('stderr') { should be_empty }
  end
end

control 'core-plans-util-linux-binaries' do
  impact 1.0
  title 'Ensure util-linux works'
  desc '
  To test the util-linux binaries we first find the package path.
  Using the package path to locate the binaries, we check that they exist and are executable.
  Then we run version checks on them to prove that they work.
  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  hab_pkg_path = hab_pkg_path.stdout.strip
  version = hab_pkg_path.split('/')[5]

  binaries_to_test = command("ls #{File.join(hab_pkg_path, 'bin')}")
  describe binaries_to_test do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end
  binaries_to_test = binaries_to_test.stdout.strip.split().to_a

  binaries_to_test.each do |binary|
    describe file("#{File.join(hab_pkg_path, 'bin', binary)}") do
      it { should exist }
      it { should be_executable }
    end
  end

  binaries_to_test.each do |binary|
    describe command("#{File.join(hab_pkg_path, 'bin', binary)} --version") do
      its('stdout') { should match /#{binary} from util-linux #{version}/ }
      #its('stderr') { should be_empty }
      its('exit_status') { should eq 0 }
    end
  end

end
