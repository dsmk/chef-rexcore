#
# Cookbook Name:: jetty
# Attributes:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Change the default to false as we don't yet have push jobs working.
#
#default['rexden']['enable_push_jobs'] = true
default['rexden']['enable_push_jobs'] = false

# defaults for Chef push jobs
#
default['push_jobs']['whitelist'] = {
  "chef-client" => "chef-client",
}

# chef push jobs requires full URLs for Windows
#
if node['os'] == 'windows' then
  default['push_jobs']['package_url'] = "https://opscode-push-jobs-client-packages.s3.amazonaws.com/push-1.3-stable/windows/2008r2/x86_64/push-jobs-client-1.3.4-1.msi"
  default['push_jobs']['package_checksum'] = "622f6fa1f1f9828ada9c3f44b82f4abb90522050d961d373d19990db4e6a124a"
end

# do not configure rsyslog to send data to a remote log server
default['rexden']['syslog_server'] = 'none'
# you would want to set this in a location or role instead of globally
#default['rexden']['syslog_server'] = 'buckbeak.rexden.us'
# port 514 is the default port for standard syslog
#default['rexden']['syslog_port'] = 514
# port 5544 is the port we used for the ELK-based log server
default['rexden']['syslog_port'] = 5544
default['rexden']['syslog_work_dir'] = '/var/cache/rsyslog'

# Ark client defaults
#
default['rexden']['ark_client_disable'] = false
default['rexden']['ark_server_name'] = 'fawkes.rexden.us'
default['rexden']['ark_server_ip'] = '192.168.8.19'
default['rexden']['ark_server_root'] = '/opt/archive/hosts'
# set the following variable to mount a remote archive

#
# Defaults for monitor server (Icinga2 classic ui version)
#
default['icinga2']['classic_ui']['users']['guest'] = '$apr1$cA/eVUgT$aIoWUPwV5uONJoYslb7lg0'
default['icinga2']['classic_ui']['authorized_for_all_services'] = %w(icingaadmin guest)
default['icinga2']['classic_ui']['authorized_for_all_hosts'] = %w(icingaadmin guest)
#default['icinga2']['pnp'] = true

#
# Defaults for monitor server (Icinga2 new web interface)
#
#default['icinga2']['classic_ui']['enable'] = false
#default['icinga2']['web2']['enable'] = true

#
#
default['icinga2']['ido']['load_schema'] = true
default['icinga2']['ido']['type'] = 'mysql'

#
# VMware environment we want to monitor
#
default['rexden']['host-templates'] = [
  { name: 'esxi-host', cmd: 'ping4' },
]
default['rexden']['misc-hosts'] = [
  { name: 'dobby.rexden.us', ip: '192.168.8.11', group: 'elves', type: 'esxi-host' },
  { name: 'hokey.rexden.us', ip: '192.168.8.13', group: 'elves', type: 'esxi-host' },
  { name: 'kreacher.rexden.us', ip: '192.168.8.15', group: 'elves', type: 'esxi-host' },
]

# 
# LibreNMS sample configuration
#
default['librenms']['users'] = [
  { name: "dsmk", pass: "ChangeMe", email: "david@rexden.us" },
  { name: "guest", pass: "guest", email: "" },
]
default['librenms']['hosts'] = [
  { name: "192.168.8.11", community: "public", version: "v2c" },
  { name: "192.168.8.13", community: "public", version: "v2c" },
  { name: "192.168.8.15", community: "public", version: "v2c" },
  { name: "192.168.8.251", community: "public", version: "v2c" },
]

# 
# Log server (splunk version)
#
default['rexden']['splunk_version'] = "6.3.2-aaff59bb082c"
default['rexden']['splunk_download_url'] = 'http://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.3.2&product=splunk&filename=splunk-6.3.2-aaff59bb082c-linux-2.6-x86_64.rpm&wget=true'
#default['splunk']['accept_license'] = true
#default['splunk']['is_server'] = true

#
# Log server (graylog version)
#
default['java']['jdk_version'] = '7'
default['java']['install_flavor'] = 'openjdk'
# This is necessary since our VMware templates appear to be Red Hat which produces differences
# from the Centos vagrant boxes.
#default['mongodb']['install_method'] = 'mongodb-org'
#default['mongodb']['package_name'] = 'mongodb-org'
# here is another approach to the above
default['mongodb']['user'] = 'mongodb'
default['mongodb']['group'] = 'mongodb'
default['mongodb']['package_name'] = 'mongodb-server'
default['mongodb']['install_method'] = 'distro'
# password_secret should be generated by pwgen -N 1 -s 96
#default['graylog2']['password_secret'] = 'SOG1Rm2YVHIOmFPJv5U8tkw1LVSTSpjgUvh3z6qX5T4gieNcuFlxKWdnYcuW1tNEaWir2AaAWWo7VObYVZbE9GvKLbTDH3CQ'
# root_password_sha2 should be generated by echo "pw" | shasum -a 256
#default['graylog2']['root_password_sha2'] = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918'
# web secret should be generated by pwgen -N 1 -s 96
#default['graylog2']['web']['secret'] = 'ZGrrlMoBDpg9yVrP0gAhbznvUbxQLh5LUyAPz79EULPqlZ1SWDm2Q7uctbL7W2bSgFqeBjvawC4DMPG0JkijA9Imch6ZvOwk'
