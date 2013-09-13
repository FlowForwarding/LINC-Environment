#
# Cookbook Name:: wireshark_ofp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'debian'
  include_recipe "wireshark_ofp::install_wireshark"
  include_recipe "wireshark_ofp::install_ofp_dissector"
else
  Chef::Log.fatal("Recipie for Wireshark supports only debian-related platforms.")
end
