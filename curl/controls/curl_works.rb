title 'Tests to confirm curl binaries work as expected'

base_dir = input("base_dir", value: "bin")
plan_origin = ENV['HAB_ORIGIN']
plan_name = input("plan_name", value: "curl")
plan_ident = "#{plan_origin}/#{plan_name}"

control 'core-plans-curl' do
  impact 1.0
  title 'Ensure curl binaries are working as expected'
  desc '
  To test the binaries that core/curl provides we first check for the installation directory.
  Using this directory we then run checks to that the binary can execute a help/version or similar command.
    $ $PKG_PATH/bin/curl --version
      curl 7.68.0 (x86_64-pc-linux-gnu) libcurl/7.68.0 OpenSSL/1.0.2t-fips zlib/1.2.11 nghttp2/1.40.0
      Release-Date: 2020-01-08
      Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s smb smbs smtp smtps telnet tftp
      Features: AsynchDNS HTTP2 HTTPS-proxy IPv6 Largefile libz NTLM NTLM_WB SSL TLS-SRP UnixSockets  '

  hab_pkg_path = command("hab pkg path #{plan_ident}")
  describe hab_pkg_path do
    its('stdout') { should_not be_empty }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  bin_dir = File.join(hab_pkg_path.stdout.strip, "/bin")

  curl_works = command("#{File.join(bin_dir, "curl")} --version")
  describe curl_works do
    its('stdout') { should match /curl #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

  curl_config_works = command("#{File.join(bin_dir, "curl-config")} --version")
  describe curl_config_works do
    its('stdout') { should match /libcurl #{hab_pkg_path.stdout.strip.split('/')[5]}/ }
    #its('stderr') { should be_empty }
    its('exit_status') { should eq 0 }
  end

end
