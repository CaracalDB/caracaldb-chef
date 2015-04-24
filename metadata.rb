name             'caracaldb'
maintainer       "jdowling"
maintainer_email "jdowling@company.com"
license          "Apache v2.0"
description      'Installs/Configures caracaldb'
version          "0.1"

recipe            "caracaldb::default", "Installs and starts caracaldb"
recipe            "caracaldb::bootstrap", "Installs and starts caracaldb master"
recipe            "caracaldb::datanode", "Installs and starts caracaldb slave"

depends 'kagent'
depends 'java'
depends 'ark'

%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

attribute "caracaldb/version",
:description => "Version of caracaldb",
:type => 'string',
:default => "0.1"


attribute "caracaldb/url",
:description => "Url to download binaries for caracaldb",
:type => 'string',
:default => ""

attribute "caracaldb/user",
:description => "Run caracaldb as this user",
:type => 'string',
:default => "caracaldb"

