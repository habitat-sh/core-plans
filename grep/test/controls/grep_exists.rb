grep_path = attribute('grep_path', default: '/bin/grep')

describe file(grep_path) do
  it { should exist }
end
