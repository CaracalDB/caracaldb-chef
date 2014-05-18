node.default['java']['jdk_version'] = 8
node.default['java']['install_flavor'] = "oracle"

include_recipe "java"

group node[:caracaldb][:group] do
  action :create
end

user node[:caracaldb][:user] do
  gid node[:caracaldb][:group]
  supports :manage_home => true
  action :create
  home "/home/#{node[:caracaldb][:user]}"
  system true
  shell "/bin/bash"
end

group node[:caracaldb][:group] do
  action :modify
  members node[:caracaldb][:user]
  append true
end


directory node[:caracaldb][:dir] do
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "0755"
  recursive true
  action :create
end

directory node[:caracaldb][:home] do
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "0755"
  recursive true
  action :create
end

directory node[:caracaldb][:bin_dir] do
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "0755"
  recursive true
  action :create
end


directory node[:caracaldb][:logs_dir] do
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "0755"
  action :create
end


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
        cp -rf * #{node[:caracaldb][:home]}
        chown -RL #{node[:caracaldb][:user]} #{node[:caracaldb][:home]}
	EOH
end
