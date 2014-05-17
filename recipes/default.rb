
group node[:caracaldb][:group] do
  action :create
end

user node[:caracaldb][:user] do
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

my_ip = my_private_ip()

boot_ip = private_recipe_ip("caracaldb", "bootstrap")

template "application.conf" do
  source "application.conf.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "755"
  variables({
              :boot_ip => boot_ip,
              :boot_port => node[:caracaldb][:bootstrap][:port]
            })
end

template "#{node[:caracaldb][:bin_dir]}/caracaldb-start.sh" do
  source "caracaldb-start.sh.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "755"
end

template "#{node[:caracaldb][:bin_dir]}/caracaldb-stop.sh" do
  source "caracaldb-stop.sh.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode "755"
end


if node[:caracaldb][:hopagent] == true 

  hopagent_config "caracaldb" do
    service "caracaldb"
    start_script "#{node[:caracaldb][:bin_dir]}/caracaldb-start.sh"
    stop_script "#{node[:caracaldb][:bin_dir]}/caracaldb-stop.sh"
    log_file "#{node[:caracaldb][:logs_dir]}/caracaldb_out.log"
    pid_file "#{node[:caracaldb][:logs_dir]}/caracaldb.pid"
  end

end
