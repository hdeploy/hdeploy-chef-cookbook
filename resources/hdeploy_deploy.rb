resource_name :hdeploy_deploy

property :symlink, kind_of: String, required: true
property :relpath, kind_of: String
property :tgzpath, kind_of: String
property :user,    kind_of: String, default: 'www-data'
property :group,   kind_of: String, default: 'www-data'
property :active,  kind_of: TrueClass, FalseClass, default: true


action :create do

  new_resource.relpath ||= File.expand_path('../releases', new_resource.symlink) 
  new_resource.tgzpath ||= File.expand_path('../tarballs', new_resource.symlink) 

  node['hdeploy']['deploy'][new_resource.name] = {
    symlink: new_resource.symlink,
    relpath: new_resource.relpath,
    tgzpath: new_resource.tgzpath,
    user:    new_resource.user,
    group:   new_resource.group,
    active:  new_resource.active,
  }

  include_recipe 'hdeploy::client'
end