#FIXME: install server package

template '/opt/hdeploy-server/hdeploy.json' do
  mode '0644'
  owner 'root'
  group 'root'
  notifies :execute, 'execute[/opt/hdeploy-server/bin/hdeploy-ctl reconfigure]'
end

execute '/opt/hdeploy-server/bin/hdeploy-ctl reconfigure' do
  action :nothing
end
