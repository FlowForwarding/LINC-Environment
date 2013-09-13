#
# Cookbook Name:: wireshark_ofp
# Recipe:: install_wireshark
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "wireshark" do
  action :install
end

package "wireshark-common" do
  action :reconfig
  response_file "wireshark_common"
end

group "wireshark" do
  action :modify
  members "vagrant"
  append true
end
