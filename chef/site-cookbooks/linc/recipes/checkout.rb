#
# Cookbook Name:: linc
# Recipe:: checkout
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
# Clone/update LINC-Switch repository
#------------------------------------------------------------------------------#

git "linc" do
  repository linc_info['repo']['url']
  reference "master"
  action :checkout
  destination linc_info['repo']['destination']
  user "vagrant"
  group "vagrant"
end

#------------------------------------------------------------------------------#
# Clone/update LINC-Switch dependencies
#------------------------------------------------------------------------------#

linc_deps_info['repos'].each do |dep|
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
