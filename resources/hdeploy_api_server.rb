resource_name :hdeploy_api_server

property :ssl_key, kind_of: String
property :ssl_crt, kind_of: String

property :url, kind_of: String

property :cassandra_host, kind_of: String
property :cassandra_port, kind_of: Fixnum

default_action :create

require 'uri'

action :create do
  
  u = URI.parse(node['hdeploy']['api'][new_resource.name]['url'])

  if u.scheme == 'https'
    #if # Do some SSL stuff?
  end

  raise "API URL format must be http:// or https://" unless u.scheme == 'http' or u.scheme == 'https'

  node.default['hdeploy']['api'][new_resource.name] = {
    url:  new_resource.url,
    user: new_resource.user,
    pass: new_resource.pass,
  }

  include_recipe 'hdeploy::server'

end
