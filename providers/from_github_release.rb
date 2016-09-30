
action :install do

  if node['platform_family'] == 'debian'

    pkgfile = "#{new_resource.package}_#{new_resource.version}_amd64.deb"
    testcmd = "dpkg -s #{new_resource.package} | grep 'install ok installed'"

  elsif node['platform_family'] == 'rhel'

    pkgfile = "#{new_resource.package}-#{new_resource.version}.el#{node['platform_version'].to_i}.x86_64.rpm"
    testcmd = "rpm -q #{new_resource.package}"

  else
    raise "non supported platform, only RHEL and Debian/Ubuntu"
  end

  system "#{testcmd} > /dev/null 2>&1"

  # Run if the command returned an error = the package isn't already there
  if not $?.success?
    converge_by "download and install cassandra from github" do

      pkgfile_full = ::File.join(Chef::Config[:file_cache_path], pkgfile)

      remote_file pkgfile_full do
        source "https://github.com/#{new_resource.repository}/releases/download/#{new_resource.version}/#{pkgfile}"
        mode '0644'
        owner 'root'
        group 'root'
      end

      dpkg_package new_resource.package do
        source pkgfile_full
      end

      file pkgfile_full do
        action :delete
      end

    end
  end
end
