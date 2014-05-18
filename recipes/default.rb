
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


service "caracaldb" do
  supports :restart => true, :stop => true, :start => true
  action :nothing
end

template "/etc/init.d/caracaldb" do
  source "caracaldb.erb"
  owner node[:hop][:user]
  group node[:hop][:group]
  mode 0754
  notifies :enable, resources(:service => "caracaldb"), :immediately
  notifies :restart, resources(:service => "caracaldb")
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
