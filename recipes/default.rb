bash "caracaldb_start" do
    user "root"
    code <<-EOF

    #{node[:caracaldb][:version_dir]}/caracal_start.sh
#touch #{node[:caracaldb][:version_dir]}/.started
EOF
#  not_if { ::File.exists?( "#{node[:caracaldb][:version_dir]}/.installed" ) }
end


