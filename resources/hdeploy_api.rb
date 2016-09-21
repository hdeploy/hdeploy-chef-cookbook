resource_name :hdeploy_api

property :url,  kind_of: String, required: true
property :user, kind_of: String, required: true
property :pass, kind_of: String, required: true

default_action :create

require 'uri'

action :create do
  
  u = URI.parse(new_resource.url)
  raise "API URL format must be http:// or https://" unless u.scheme == 'http' or u.scheme == 'https'

  node.default['hdeploy']['api'][new_resource.name] = {
    url:  new_resource.url,
    user: new_resource.user,
    pass: new_resource.pass,
  }
end
