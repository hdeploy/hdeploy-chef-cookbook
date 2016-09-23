# the recipe that includes the enterprise cookbook MUST set a few things:

# Set twice depending on where it's running
default['hdeploy']['sysvinit_id'] = 'HD'
default['hdeploy']['install_path'] = '/opt/hdeploy' # This is very important for the enterprise cookbook
default['hdeploy']['fqdn'] = (node['fqdn'] or node['hostname']).downcase

# And for server
default['hdeploy-server']['install_path'] = '/opt/hdeploy-server'
default['hdeploy-server']['sysvinit_id'] = 'HS'
default['hdeploy-server']['fqdn'] = (node['fqdn'] or node['hostname']).downcase


%w[client_check_deploy client_keepalive].each do |component|
  default['hdeploy'][component]['enable'] = true
  default['hdeploy'][component]['exec_interval'] = 60
  default['hdeploy'][component]['log_directory'] = "/var/log/hdeploy/#{component}"
  default['hdeploy'][component]['log_rotation']['file_maxbytes'] = 104857600
  default['hdeploy'][component]['log_rotation']['num_to_keep'] = 10
end

default['hdeploy-server']['nginx']['log_directory'] = '/var/log/hdeploy/nginx/output'
default['hdeploy-server']['nginx']['log_rotation']['file_maxbytes'] = 104857600
default['hdeploy-server']['nginx']['log_rotation']['num_to_keep'] = 10

