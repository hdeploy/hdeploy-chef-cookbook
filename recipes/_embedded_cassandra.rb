cver = '3.7-omnibus1'
baseurl = "https://github.com/hdeploy/omnibus-cassandra/releases/download/#{cver}"

# https://github.com/hdeploy/omnibus-cassandra/releases/download/3.7-omnibus1/cassandra-3.7-omnibus1.el6.x86_64.rpm

# For now we support ubuntu amd64 and redhat/centos EL6, EL7
if node['platform_family'] == 'debian'
  cfile = "cassandra_#{cver}_amd64.deb"
elsif node['platform_family'] == 'rhel'
  if node['platform_version'].to_i == 6 or node['platform_version'].to_i == 7
    cfile = "cassandra-#{cver}.el#{node['platform_version'].to_i}.x86_64.rpm"
  else
    raise "your platform is not yet supported - ask if you want support"
  end
else
  raise "your platform is not yet supported - ask if you want support"
end

package 'cassandra' do
  source File.join(baseurl,cfile)
end