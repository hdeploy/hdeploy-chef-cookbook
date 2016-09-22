resource_name :hdeploy_build

property :git,           kind_of: String, required: true
property :subdir,        kind_of: String
property :prune,         kind_of: String, default: 5
property :tmp_build_dir, kind_of: String, default: '~/hdeploy_tmp' # The actual CLI will expand it
property :repository,    kind_of: String, default: "default" #FIXME: support arrays too


action :create do

  new_resource.relpath ||= File.expand_path('../releases', new_resource.symlink) 
  new_resource.tgzpath ||= File.expand_path('../tarballs', new_resource.symlink) 

  raise "no such repository #{new_resource.repository} use hdeploy_repository to define it" unless 
    (new_resource.repository == 'default' or node['hdeploy']['repository'].has_key?(new_resource.repository))

  node['hdeploy']['deploy'][new_resource.name] = {
    git:           new_resource.git,
    subdir:        new_resource.subdir,
    prune:         new_resource.prune,
    tmp_build_dir: new_resource.tmp_build_dir,
    repository:    new_resource.repository,
  }

  include_recipe 'hdeploy::client'
end