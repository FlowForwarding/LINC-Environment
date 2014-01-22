#
# Cookbook Name:: linc
# Recipe:: create-dirs
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#------------------------------------------------------------------------------#
# Create an appropriate directory structure for LINC-Switch
#------------------------------------------------------------------------------#

directory dir = node['linc']['destination'] do
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

node['linc']['deps'].each do |key, dep|
  directory dir = dep['destination'] do
    owner "vagrant"
    group "vagrant"
    mode 00755
    action :create
    recursive true
    only_if {
      node['linc']['install_deps'] == true
    }
    not_if {
      File.exist?(dir)
    }
  end
end
