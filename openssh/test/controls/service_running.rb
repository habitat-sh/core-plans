control 'ensure sshd processes are all running and owned by correct owner' do

  describe processes(Regexp.new("\/sbin\/sshd")) do
    its('entries.length') { should eq 1 }
    its('users') { should eq ['root'] }
  end

end 