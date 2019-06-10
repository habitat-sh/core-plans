name "windows"

default_source :supermarket
default_source :chef_repo, './cookbooks' do |s|
  s.preferred_for 'windows'
end

run_list ['hardening::default']
