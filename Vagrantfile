# VirutalBox Guest Additions installer for ubuntu cloud images.
# Motivated by: https://github.com/dotless-de/vagrant-vbguest/issues/43#issuecomment-21780432
begin
  require 'vagrant-vbguest'
  class CloudUbuntuVagrant < VagrantVbguest::Installers::Ubuntu
    def install(opts=nil, &block)
      communicate.sudo('sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list ', opts, &block)
      communicate.sudo('apt-get update', opts, &block)
      communicate.sudo('apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11', opts, &block)
      @vb_uninstalled = true
      super
    end

    def running?(opts=nil, &block)
      return false if @vb_uninstalled
      super
    end
  end
  vagrant_vbguest_installed = true
rescue LoadError
  vagrant_vbguest_installed = false
end

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Choose the box. It it does not exists it will be downloaded.
  config.vm.box = "ubuntu-12.04-amd64-daily"

  # Set the url for the box.
  config.vm.box_url =
    "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  # Share folders
  config.vm.synced_folder "development", "/home/vagrant/development"

  # Set the custom installer for VirtualBox Guest Additions.
  if vagrant_vbguest_installed
    config.vbguest.installer = CloudUbuntuVagrant
  end

  # Set the hostname
  config.vm.hostname = "linc-dev"

  # Enable X11 forwarding
  config.ssh.forward_x11 = true

  # VirtualBox provider configuration.
  config.vm.provider :virtualbox do |vb|
    # Set to true if you want the virtualbox to start the VM's UI
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Version of Chef to install in the box.
  config.omnibus.chef_version = :latest

  # Subdirectory config for librarian-chef
  config.librarian_chef.cheffile_dir = "chef"

  # Enable provisioning with Chef-Solo.
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.data_bags_path = "chef/data_bags"

    chef.json = {
      :erlang => {
        :install_method => 'esl'
      },
      :linc => {
        :deps => true,
        :ping_example => true
      }
    }

    chef.add_recipe 'git'
    chef.add_recipe 'erlang'
    #chef.add_recipe 'xfce4'
    chef.add_recipe 'linc'
    chef.add_recipe 'wireshark_ofp'
    chef.add_recipe 'mininet'
  end
end
