libpath = File.expand_path '../../../kagent/libraries', __FILE__

node.default['java']['jdk_version'] = 7
include_recipe "java"

user node[:caracaldb][:user] do
  action :create
  system true
  shell "/bin/bash"
#  not_if "getent passwd #{node[:caracaldb]['user']}"
end


# See ark resource here: https://github.com/burtlo/ark
# It will: fetch it to to /var/cache/chef/
# unpack it to the default path (/usr/local/XXX-1.2.3)
# create a symlink for :home_dir (/usr/local/XXX) 
# add /user/local/XXX/bin to the enviroment PATH variable
 ark 'caracaldb' do
   url node[:caracaldb][:url]
   version node[:caracaldb][:version]
   path node[:caracaldb][:version_dir]
   home_dir node[:caracaldb][:home_dir]
#   checksum  '89ba5fde0c596db388c3bbd265b63007a9cc3df3a8e6d79a46780c1a39408cb5'
   append_env_path true
   owner node[:caracaldb][:user]
 end

# Get the private-ip of this machine
private_ip = my_private_ip()
# public_ip = my_public_ip()
# returns the first caracaldb::bootstrap private_ip in the list
bootstrap_private_ip = private_recipe_ip("caracaldb","bootstrap")

file "#{node[:caracaldb][:version_dir]}/application.conf" do
  owner node[:caracaldb][:user]
  action :delete
end


template "#{node[:caracaldb][:version_dir]}/application.conf" do
  source "application.conf.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "755"
  variables({
              :bootstrap_ip => bootstrap_private_ip,
              :my_ip => private_ip
            })
  action :create_if_missing
end

