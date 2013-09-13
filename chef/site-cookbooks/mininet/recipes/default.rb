#
# Cookbook Name:: mininet
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'debian'
  include_recipe 'mininet::prepare'
  include_recipe 'mininet::install'
else
  Chef::Log.fatal("Recipie for Mininet supports only debian-related platforms.")
end
