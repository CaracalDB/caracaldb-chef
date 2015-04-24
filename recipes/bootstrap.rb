
master_ip = my_private_ip()

bash "caracaldb_install_bash" do
    user "root"
    code <<-EOF

# Do something here...

touch #{node[:caracaldb][:version_dir]}/.installed
EOF
  not_if { ::File.exists?( "#{node[:caracaldb][:version_dir]}/.installed" ) }
end

#service "caracaldb-master" do
#  supports :restart => true, :stop => true, :start => true, :status => true
#  action :nothing
#end

template "#{node[:caracaldb][:version_dir]}/bin/master.sh" do
  source "master.sh.erb"
  owner node[:caracaldb][:user]
  group node[:caracaldb][:group]
  mode 0754
#  notifies :enable, "service[caracaldb]"
#  notifies :restart,"service[caracaldb]", :immediately
end

