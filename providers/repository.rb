# Made this old style rather than new style because this way
# is it compatible with chef 11 and also early versions of chef 12.

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  # FIXME: only type supported is local.
  raise "only supported type is :local" unless new_resource.type == :local

  node.default['hdeploy']['repository'][new_resource.name] = {
    type:  new_resource.type,
    path:  new_resource.path,
    url:   new_resource.url,
    serve: new_resource.serve,
  }

  if new_resource.serve or File.directory?('/opt/hdeploy-server')
    converge_by "run hdeploy::server recipe" do
      run_context.include_recipe 'hdeploy::server'
    end
  end
end

action :delete do
  node.default['hdeploy']['repository'].delete(new_resource.name)

  converge_by "run hdeploy::server recipe" do
    run_context.include_recipe 'hdeploy::server'
  end  

end