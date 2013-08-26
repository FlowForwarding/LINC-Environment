#
# Cookbook Name:: linc
# Recipe:: wireshark
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform_family'] == 'debian'

  #------------------------------------------------------------------------------#
  # Install wireshark
  #------------------------------------------------------------------------------#

  # include_recipe "build-essential"

  # wireshark_deps = ["libgtk2.0", "libgtk2.0-dev", "libglib2.0-dev", "libpcap0.8-dev"]
  # wireshark_deps.each do |dep|
  #   package dep do
  #     action :install
  #   end
  # end

  # remote_file File.join(Chef::Config[:file_cache_path], "wireshark-#{node['wireshark']['version']}.tar.bz2") do
  #   source "http://wiresharkdownloads.riverbed.com/wireshark/src/wireshark-#{node['wireshark']['version']}.tar.bz2"
  #   owner "root"
  #   mode 0644
  #   notifies :run, "bash[install-wireshark]", :immediately
  # end

  # bash "install-wireshark" do
  #   user "root"
  #   cwd Chef::Config[:file_cache_path]
  #   code <<-EOS
  #     tar -xjf wireshark-#{node['wireshark']['version']}.tar.bz2
  #     (cd wireshark-#{node['wireshark']['version']} && ./configure && make && make install)
  #   EOS
  #   action :nothing
  # end

  package "wireshark" do
      action :install
  end

  directory desktop_dir = "/home/vagrant/Desktop" do
    owner "vagrant"
    group "vagrant"
    mode 00755
    action :create
    only_if {
      ! File.exist?(desktop_dir)
    }
  end

  file "/home/vagrant/Desktop/Wireshark.desktop" do
    owner "vagrant"
    group "vagrant"
    action :create
    content "[Desktop Entry]
             Version=1.0
             Type=Application
             Name=Wireshark
             Comment=Network traffic analyzer
             Exec=wireshark %f
             Icon=wireshark
             Path=
             Terminal=false
             StartupNotify=false"
  end

  package "wireshark-common" do
    action :reconfig
    response_file "wireshark_common"
  end

  group "wireshark" do
    action :modify
    members "vagrant"
    append true
  end

  #------------------------------------------------------------------------------#
  # Install wireshark OpenFlow dissector
  #------------------------------------------------------------------------------#

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
      (cd /usr/lib/wireshark/libwireshark1/plugins
      (cp #{ofdissector_dir}/src/openflow.so . && chmod 644 openflow.so)
    EOS
    action :nothing
  end

else
  Chef::Log.fatal("Recipie for Wireshark supports only debian-related platforms.")
end
