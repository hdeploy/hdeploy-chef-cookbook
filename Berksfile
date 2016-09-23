source "https://supermarket.chef.io"

cookbook 'enterprise', :git => 'https://github.com/hdeploy/enterprise-chef-common' # I patched master
cookbook 'hdeploy', :path => '.'

# Don't know why it's 1.6.0 but the original did that so ...
cookbook 'runit', :git => 'https://github.com/hdeploy/runit', :tag => 'v1.6.0'

