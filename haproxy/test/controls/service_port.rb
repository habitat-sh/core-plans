control 'ensure haproxy service is listening' do
  describe port("80") do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('processes') { should include 'haproxy' }
  end
end
