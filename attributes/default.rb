include_attributes "hopagent"
default[:caracaldb][:version]                 = "0.1"
default[:caracaldb][:user]                    = "caracal"
default[:caracaldb][:group]                   = "caracal"
default[:caracaldb][:dir]                     = "/srv"
default[:caracaldb][:home]                    = "#{default[:caracaldb][:dir]}/caracaldb-#{default[:caracaldb][:version]}"
default[:caracaldb][:download_url]            = "http://cloud7.sics.se/caracaldb-#{default[:caracaldb][:version]}.tgz"
default[:caracaldb][:logs_dir]                = "#{default[:caracaldb][:home]}/logs"
default[:caracaldb][:conf_dir]                = "#{default[:caracaldb][:home]}"

default[:caracaldb][:bootstrap][:public_ips]  = ['10.0.2.15']
default[:caracaldb][:bootstrap][:private_ips] = ['10.0.2.15']
