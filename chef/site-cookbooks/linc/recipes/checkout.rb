#
# Cookbook Name:: linc
# Recipe:: checkout
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#------------------------------------------------------------------------------#
# Clone/update LINC-Switch repository
#------------------------------------------------------------------------------#

git "linc" do
  repository node['linc']['url']
  reference "master"
  action :checkout
  destination node['linc']['destination']
  user "vagrant"
  group "vagrant"
end

#------------------------------------------------------------------------------#
# Clone/update LINC-Switch dependencies
#------------------------------------------------------------------------------#

node['linc']['deps'].each do |key, dep|
  git "linc-#{key}-dep" do
    repository dep['url']
    reference "master"
    action :checkout
    destination dep['destination']
    only_if {
      node['linc']['install_deps'] == true
    }
    user "vagrant"
    group "vagrant"
  end
end
