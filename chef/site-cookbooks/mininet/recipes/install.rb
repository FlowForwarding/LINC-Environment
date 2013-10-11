#
# Cookbook Name:: mininet
# Recipe:: install
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "mininet" do
  repository "https://github.com/FlowForwarding/mininet.git"
  reference "master"
  action :sync
  destination node['mininet']['install_dir']
  user "vagrant"
  group "vagrant"
end

execute "install mininet" do
  command "cd #{node['mininet']['install_dir']} && util/install.sh -3nfxL"
end
