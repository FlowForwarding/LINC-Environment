#
# Cookbook Name:: linc
# Recipe:: prepare_ping_exapmle
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#------------------------------------------------------------------------------#
# Install dependencies and setup a template for ping_example script
#------------------------------------------------------------------------------#

package "uml-utilities" do
  action :install
  only_if {
    node['linc']['install_ping_example'] == true
  }
end

package "tcpreplay" do
  action :install
  only_if {
    node['linc']['install_ping_example'] == true
  }
end

linc_root = node['linc']['destination']
interfaces = node['linc']['ping_example']['interfaces']
sys_config_relative = "rel/files/sys.config"
controller_port = node['linc']['ping_example']['controller_port']

template node['linc']['ping_example']['file'] do
  owner "vagrant"
  group "vagrant"
  source "ping_example.sh.erb"
  mode 00755
  variables(
            :config_gen_bin => "#{linc_root}/scripts/config_gen",
            :config_gen_bin_args => " -s 0 #{interfaces.join(" ")} -c tcp:127.0.0.1:#{controller_port}"\
                                    " -o #{linc_root}/#{sys_config_relative}",
            :linc_root => linc_root,
            :interfaces => interfaces.join(" "),
            :linc_bin => "#{linc_root}/rel/linc/bin/linc",
            :linc_bin_args => "console",
            :controller_bin => "#{linc_root}/scripts/of_controller_v4.sh",
            :controller_bin_args => "-d -p #{controller_port} -s table_miss",
            :ping_in_int => interfaces[0],
            :ping_data => "#{linc_root}/pcap.data/ping.pcap",
            :sys_config_relative => sys_config_relative
            )
  only_if {
    node['linc']['install_ping_example'] == true
  }
end
