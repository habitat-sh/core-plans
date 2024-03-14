title 'Nginx base plan tests'

plan_name = input('plan_name', value: 'nginx')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'base-plans-nginx-port' do
    impact 1.0
    title 'Ensure Nginx is running on the correct port'
    desc ''

    describe port(80) do
        it { should be_listening }
    end
end
