#FIXME: install server package
directory "/opt/hdeploy-server" do
  mode '0755'
  owner 'root'
  group 'root'
end

template '/opt/hdeploy-server/hdeploy-server.json' do
  mode '0644'
  owner 'root'
  group 'root'
  notifies :run, 'execute[hdeploy-server-ctl reconfigure]'
end

execute 'hdeploy-server-ctl reconfigure' do
  command '/opt/hdeploy-server/bin/hdeploy-server-ctl reconfigure'
  action :nothing
end
