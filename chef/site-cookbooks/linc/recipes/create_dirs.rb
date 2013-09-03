#
# Cookbook Name:: linc
# Recipe:: create-dirs
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#------------------------------------------------------------------------------#
# Load data from data bags
#------------------------------------------------------------------------------#

data_bag 'repos'
linc_info = data_bag_item 'repos', 'linc'
linc_deps_info = data_bag_item 'repos', 'linc-deps'

#------------------------------------------------------------------------------#
# Create an appropriate directory structure for LINC-Switch
#------------------------------------------------------------------------------#

directory dir = linc_info['repo']['destination'] do
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
  recursive true
  not_if {
    File.exist?(dir)
  }
end

#------------------------------------------------------------------------------#
# Create an appropriate directory structure for LINC-Switch dependencies
# if required
#------------------------------------------------------------------------------#

linc_deps_info['repos'].each do |dep|
  directory dir = dep['destination'] do
    owner "vagrant"
    group "vagrant"
    mode 00755
    action :create
    recursive true
    only_if {
      node['linc']['deps'] == true
    }
    not_if {
      File.exist?(dir)
    }
  end
end
