
bash "caracaldb_install_bash" do
    user "root"
    code <<-EOF

# Do something here...

touch #{node[:caracaldb][:version_dir]}/.started
EOF
  not_if { ::File.exists?( "#{node[:caracaldb][:version_dir]}/.installed" ) }
end

#service "caracaldb-master" do
#  supports :restart => true, :stop => true, :start => true, :status => true
#  action :nothing
#end

