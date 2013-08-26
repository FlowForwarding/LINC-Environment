#
# Cookbook Name:: linc
# Recipe:: linc-code
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
# Create an appropriate directory structure and clone/update LINC-Switch
# repository
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

git "linc" do
  repository linc_info['repo']['url']
  reference "master"
  action :checkout
  destination linc_info['repo']['destination']
  user "vagrant"
  group "vagrant"
end

#------------------------------------------------------------------------------#
# If LINC-Swtich dependencies are required create an appropriate directory
# structure and clone/update LINC-Switch dependencies
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

  git "linc-#{dep['name']}-dep" do
    repository dep['url']
    reference "master"
    action :checkout
    destination dep['destination']
    only_if {
      node['linc']['deps'] == true
    }
    user "vagrant"
    group "vagrant"
  end
end
