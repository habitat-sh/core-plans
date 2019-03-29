control 'ensure haproxy process is running and owned by correct owner' do
  describe processes(Regexp.new("haproxy")) do
    its('entries.length') { should be >= 1 }
    its('users') { should include 'root' }
  end

  describe http('http://localhost') do
    its('status') { should cmp 200 }
    its('body') { should match /Testing Haproxy Load Balancer/ }
  end
end
