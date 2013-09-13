#
# Cookbook Name:: linc
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "linc::create_dirs"
include_recipe "linc::checkout"
include_recipe "linc::prepare_ping_example"
