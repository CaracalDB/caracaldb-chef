include_attributes "kagent"

default[:caracaldb][:version] = "0.0.6"
default[:caracaldb][:url] = "http://cloud7.sics.se/caracal/caracal-#{node[:caracaldb][:version]}.tar.gz"

default[:caracaldb][:user] = "caracaldb"
default[:caracaldb][:group] = "caracaldb"

default[:caracaldb][:version_dir] = "/usr/local/caracaldb-#{node[:caracaldb][:version]}"
default[:caracaldb][:home_dir] = "/usr/local/caracaldb"

default[:caracaldb][:bootstrap][:port] = 
default[:caracaldb][:datanode][:port] = 
default[:caracaldb][:threshold] = 3

default[:caracaldb][:bootstrap][:public_ips] = ['10.0.2.15']
default[:caracaldb][:bootstrap][:private_ips] = ['10.0.2.15']
default[:caracaldb][:datanode][:public_ips] = ['10.0.2.15']
default[:caracaldb][:datanode][:private_ips] = ['10.0.2.15']


