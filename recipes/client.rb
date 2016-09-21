#FIXME: install client package

template '/opt/hdeploy/hdeploy.json' do
  mode '0644'
  owner 'root'
  group 'root'
  notifies :execute, 'execute[/opt/hdeploy/bin/hdeploy-ctl reconfigure]'
end

execute '/opt/hdeploy/bin/hdeploy-ctl reconfigure' do
  action :nothing
end
