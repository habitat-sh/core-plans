mysql_path = attribute('grep_path', default: '/bin/mysql')

describe file(mysql_path) do
  it { should exist }
end
