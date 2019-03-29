service_port = attribute('service_port', default: 2222)

control 'ensure openssh service is listening' do
  describe port(service_port) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
    its('processes') { should include 'sshd'}
  end
end
