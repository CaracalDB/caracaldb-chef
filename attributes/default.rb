
default[:caracaldb][:version]                 = "0.1"
default[:caracaldb][:user]                    = "caracal"
default[:caracaldb][:group]                   = "caracal"
default[:caracaldb][:dir]                     = "/srv"
default[:caracaldb][:home]                    = "#{default[:caracaldb][:dir]}/caracaldb-#{default[:caracaldb][:version]}"
default[:caracaldb][:server_home]             = "#{default[:caracaldb][:home]}/server"
default[:caracaldb][:restapi_home]            = "#{default[:caracaldb][:home]}/rest-api"
default[:caracaldb][:web_home]                = "#{default[:caracaldb][:home]}/web"
default[:caracaldb][:bin_dir]                 = "#{default[:caracaldb][:home]}/bin"
default[:caracaldb][:log_dir]                 = "#{default[:caracaldb][:home]}/log"
default[:caracaldb][:conf_dir]                = "#{default[:caracaldb][:home]}"

default[:caracaldb][:bootstrap][:public_ips]  = ['192.168.33.11']
default[:caracaldb][:bootstrap][:private_ips] = ['192.168.33.11']

default[:caracaldb][:bootstrap][:port]        = 9876

default[:caracaldb][:num_nodes_wait_start]    = 3

default[:caracaldb][:download_url]            = "http://cloud7.sics.se/caracal/caracaldb.tgz"

default[:caracaldb][:hopagent]                = false

default['java']['oracle']['accept_oracle_download_terms'] = true
