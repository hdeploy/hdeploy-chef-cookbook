# Base
default['hdeploy']['api_server_name'] = "localhost"
default['hdeploy']['api_port'] = 8501

default['hdeploy']['apihost'] = "http://#{node['hdeploy']['server_name']}:#{node['hdeploy']['api_port']}"

default['hdeploy']['localrepo'] = {}

# Add some nice defaults.
node['hdeploy']['localrepo'].each do |app,conf|
  # Default env
  env = 'build'
  env = node['env'] if node.has_key? 'env'
  env = node['hdeploy']['env'] if node['hdeploy'].has_key? 'env'
  env = conf['env'] if conf.has_key? 'env'

  # Override the other way
  default['hdeploy']['localrepo'][app]['env'] = env

  # Default user/group
  default['hdeploy']['localrepo'][app]['user'] = 'www-data' unless conf.has_key? 'user'
  default['hdeploy']['localrepo'][app]['group'] = 'www-data' unless conf.has_key? 'group'
end
