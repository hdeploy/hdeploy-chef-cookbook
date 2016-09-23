resource_name :hdeploy_repository

actions :create, :delete

property :type,  kind_of: Symbol, required: true
property :path,  kind_of: String, default: "/var/lib/hdeploy/artifact_repository" # Required only if type is local ...
property :url,   kind_of: String, default: "http://127.0.0.1:8502"

# If we server it, it will configure nginx or other. This is what will or not activate hdeploy-server
property :serve, kind_of: [TrueClass, FalseClass], default: false
