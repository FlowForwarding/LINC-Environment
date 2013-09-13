#
# Cookbook Name:: wireshark_ofp
# Recipe:: install_ofp_dissector
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

ofdissector_deps = ["wireshark-dev", "libglib2.0-dev", "scons"]
ofdissector_deps.each do |dep|
  package dep do
    action :install
  end
end

ofdissector_dir = File.join(Chef::Config[:file_cache_path], "wireshark-ofdissector")

git "wireshark-ofdissector" do
  repository "https://github.com/CPqD/ofdissector"
  reference "master"
  action :sync
  destination ofdissector_dir
  notifies :run, "bash[install-wireshark-ofdissector]", :immediately
end

bash "install-wireshark-ofdissector" do
  cwd "#{ofdissector_dir}/src"
  code <<-EOS
      (export WIRESHARK=/usr/include/wireshark && scons install)
      cd /usr/lib/wireshark/libwireshark1/plugins
      (cp #{ofdissector_dir}/src/openflow.so . && chmod 644 openflow.so)
    EOS
  action :nothing
end
