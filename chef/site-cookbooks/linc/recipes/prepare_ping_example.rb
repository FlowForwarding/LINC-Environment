#
# Cookbook Name:: linc
# Recipe:: prepare_ping_exapmle
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

data_bag 'exapmles'
example_data = data_bag_item 'examples', 'ping'

#------------------------------------------------------------------------------#
# Install dependencies and setup a template for ping_example script
#------------------------------------------------------------------------------#

package "uml-utilities" do
  action :install
  only_if {
    node['linc']['ping_example'] == true
  }
end

package "tcpreplay" do
  action :install
  only_if {
    node['linc']['ping_example'] == true
  }
end

linc_root = linc_info['repo']['destination']
interfaces = example_data['interfaces']
sys_config_relative = "rel/files/sys.config"

template "/home/vagrant/ping_example" do
  owner "vagrant"
  group "vagrant"
  source "ping_example.sh.erb"
  mode 00755
  variables(
            :config_gen_bin => "#{linc_root}/scripts/config_gen",
            :config_gen_bin_args => " -s 0 #{interfaces.join(" ")} -o #{linc_root}/#{sys_config_relative} -c tcp:127.0.0.1:6653",
            :linc_root => linc_root,
            :interfaces => interfaces.join(" "),
            :linc_bin => "#{linc_root}/rel/linc/bin/linc",
            :linc_bin_args => "console",
            :controller_bin => "#{linc_root}/scripts/of_controller_v5.sh",
            :controller_bin_args => "-d -p 6653 -s table_miss",
            :ping_in_int => interfaces[0],
            :ping_data => "#{linc_root}/pcap.data/ping.pcap",
            :sys_config_relative => sys_config_relative
            )
  only_if {
    node['linc']['ping_example'] == true
  }
end
