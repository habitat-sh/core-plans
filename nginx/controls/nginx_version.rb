title 'Nginx base plan tests'

plan_name = input('plan_name', value: 'nginx')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
hab_path = input('hab_path', value: 'hab')

control 'base-plans-nginx-version' do
    impact 1.0
    title 'Ensure version is correct'
    desc ''

    # Get the ident of the package
    cmd_to_get_ident = command("#{hab_path} pkg path #{plan_ident}")

    describe cmd_to_get_ident do
        its('exit_status') { should eq 0 }
        its('stdout') { should_not be_empty }
    end

    # Get the ident from the command
    nginx_pkg_ident = cmd_to_get_ident.stdout.strip

    # Ensure the version is set correctly by looking at the version of nginx
    # and comparing with element 5 in the path to the ident
    describe command("#{nginx_pkg_ident}/bin/nginx -v") do
        its('exit_status') { should eq 0 }
        its('stderr') { should_not be_empty }
        its('stderr') { should match /nginx version: nginx\/#{nginx_pkg_ident.split("/")[5]}/ }
        its('stdout') { should be_empty }
    end
end
