#
# Cookbook Name:: mininet
# Recipe:: prepare
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if not node.recipes.include?('erlang')
  node.set['erlang']['install_method'] =  'esl'
  include_recipe 'erlang'
end

deps = [ "git-core", "uml-utilities", "bridge-utils" ]
deps.each do |dep|
  package dep do
    action :install
  end
end

directory node['mininet']['install_dir'] do
  owner "vagrant"
  group "vagrant"
  mode 00755
  action :create
  recursive true
  not_if {
    File.exist?(node['mininet']['install_dir'])
  }
end
