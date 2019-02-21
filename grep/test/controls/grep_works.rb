grep_test = attribute('grep_test', default: '/bin/grep Sleeping /hab/svc/grep/hooks/run')

describe bash(grep_test) do
  its('stdout') { should match /echo "Sleeping ..."/ }
  its('stderr') { should eq '' }
  its('exit_status') { should eq 0 }
end
