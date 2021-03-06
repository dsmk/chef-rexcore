
package 'rsync'

group 'backup' do
  gid "900"
end

user 'backup' do
  comment "Push Backup User"
  home "/home/backup"
  uid "900"
  gid "backup"
  manage_home true
end

directory '/home/backup/.ssh' do
  user 'backup'
  group 'backup'
  mode '0700'
end

cookbook_file '/home/backup/.ssh/authorized_keys' do
  source 'ark/server/backup-authorized_keys'
  user 'backup'
  group 'backup'
  mode '0700'
end

cookbook_file '/home/backup/do-push-rsync.sh' do
  source 'ark/server/do-push-rsync.sh'
  user 'backup'
  group 'backup'
  mode '0755'
end

template '/home/backup/clients' do
  source 'ark/server/clients.erb'
  user 'backup'
  group 'backup'
  mode '0755'
end

template '/usr/local/sbin/push-rsync.sh' do
  source 'ark/server/push-rsync.sh.erb'
  user 'root'
  group 'root'
  mode '0555'
end

cookbook_file '/etc/push-rsync.conf.template' do
  source 'ark/server/push-rsync.conf.template'
  user 'root'
  group 'root'
  mode '0444'
end

cookbook_file '/etc/sudoers.d/ark' do
  source 'ark/server/ark.sudoers'
  user 'root'
  group 'root'
  mode '0440'
end

directory '/var/cache/push-rsync' do
  user 'root'
  group 'root'
  mode '0750'
end

directory '/opt/archive' do
  user 'root'
  group 'root'
  mode '0755'
end

# vi: expandtab ts=2 
