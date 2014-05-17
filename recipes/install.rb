node.default['java']['jdk_version'] = 8
node.default['java']['install_flavor'] = "oracle"

include_recipe "java"

package_url = node[:caracaldb][:download_url]
Chef::Log.info "Downloading hadoop binaries from #{package_url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "0755"
  action :create_if_missing
end

base_name = File.basename(base_package_filename, ".tgz")
bash 'extract-caracaldb' do
  user "root"
  code <<-EOH
	tar -xzf #{cached_package_filename} 
        cp -rf server/* #{node[:caracaldb][:home]}
        cp -rf rest-api #{node[:caracaldb][:home]}
        cp -rf web #{node[:caracaldb][:home]}
        chown -RL #{node[:caracaldb][:user]} #{node[:caracaldb][:home]}

	EOH
end
