resource_name :hdeploy_api_server

property :ssl_key, kind_of: String
property :ssl_crt, kind_of: String

property :url, kind_of: String

property :cassandra_host, kind_of: String
property :cassandra_port, kind_of: Fixnum

default_action :create

require 'uri'

action :create do
  
  raise "You must define hdeploy_api with name #{new_resource.name}" unless node['hdeploy']['api'].has_key?(new_resource.name)
  u = URI.parse(node['hdeploy']['api'][new_resource.name]['url'])

  if u.scheme == 'https'
    if 

  raise "API URL format must be http:// or https://" unless u.scheme == 'http' or u.scheme == 'https'

  node.default['hdeploy']['api'][new_resource.name] = {
    url:  new_resource.url,
    user: new_resource.user,
    pass: new_resource.pass,
  }
end
