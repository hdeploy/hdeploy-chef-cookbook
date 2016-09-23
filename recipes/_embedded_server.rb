# Embedded server
# The CLI will only be symlinked if there is some build config activate - or the cli config explicitly activated
# This recipe is run by hdeploy-ctl reconfigure

conffile = '/opt/hdeploy-server/hdeploy-server.json'

# FIXME: rescue with nice messages? Anyway this is pretty obvious:
# if there's an error here, we are ready the config file and it messed up ...
confraw = File.read conffile
sconf = FFI_Yajl::Parse.parse(confraw)

# Two parts of the config are interesting to us: api and repository
# They both configure NGINX
# We will stop NGINX if there is nothing to serve ...

vhost_count = 0

#template '/opt/hdeploy-server/embedded/nginx/conf/nginx.conf'

if sconf.has_key?('api')
  vhost_count += sconf['api'].count

  # Build some kind of template
end

if sconf.has_key?('repository')
  vhost_count += sconf['repository'].count

  # Build some kind of template
end

node.default['enterprise']['name'] = 'hdeploy-server' # this is the magic!!

include_recipe 'enterprise::runit'

directory node['hdeploy-server']['nginx']['log_directory'] do
  owner 'root'
  group 'root'
  mode '0700'
  recursive true
  only_if { vhost_count > 0 }
end

directory File.join(node['hdeploy-server']['nginx']['log_directory'], 'output') do
  owner 'root'
  group 'root'
  mode '0700'
  recursive true
  only_if { vhost_count > 0 }
end

# This nginx component includes api and repository
# FIXME: support other types of repositories...
component_runit_service "nginx" do
  package 'hdeploy-server'
  action :disable if vhost_count == 0
end
