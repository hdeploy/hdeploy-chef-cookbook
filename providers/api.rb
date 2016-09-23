# Made this old style rather than new style because this way
# is it compatible with chef 11 and also early versions of chef 12.

require 'uri'

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  u = URI.parse(new_resource.url)
  raise "API URL format must be http:// or https://" unless u.scheme == 'http' or u.scheme == 'https'

  node.default['hdeploy']['api'][new_resource.name] = {
    url:  new_resource.url,
    user: new_resource.user,
    pass: new_resource.pass,
  }
end