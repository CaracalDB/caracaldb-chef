libpath = File.expand_path '../../../kagent/libraries', __FILE__

master_ip = private_recipe_ip("caracaldb","master")


#service "caracaldb-slave" do
#  supports :restart => true, :stop => true, :start => true, :status => true
#  action :nothing
#end

template "#{node[:caracaldb][:version_dir]}/bin/slave.sh" do
  source "slave.sh.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode 0754
  variables({
              :master_ip => master_ip
            })
#  notifies :enable, "service[caracaldb]"
#  notifies :restart,"service[caracaldb]", :immediately
end

