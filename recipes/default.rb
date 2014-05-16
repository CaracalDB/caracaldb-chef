
group node[:hop][:group] do
  action :create
end

user node[:hop][:user] do
  supports :manage_home => true
  action :create
  home "/home/#{node[:hop][:user]}"
  system true
  shell "/bin/bash"
end

group node[:hop][:group] do
  action :modify
  members node[:hop][:user]
  append true
end


directory node[:hop][:dir] do
  owner node[:hop][:user]
  group node[:hop][:group]
  mode "0755"
  recursive true
  action :create
end

directory node[:hop][:home] do
  owner node[:hop][:user]
  group node[:hop][:group]
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

my_ip = my_private_ip()


template "application.conf" do
  source "application.conf.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "755"
  variables({
#              :listNNs => allNNs
            })
end


