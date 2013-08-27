LINC-environment
================

Environment setup for FlowForwading/LINC-Switch

Setup
=====

> The commands provided in the following steps work on Ubuntu.

1. Install [Vagrant](http://docs.vagrantup.com/v2/installation/index.html): `dpkg -i vagrant_<version>_<platform>.deb`.
1. Install Virtual Box: `sudo apt-get install virutalbox`.
1. Install  vagrant-bindler plugin: `vagrant plugin install bindler && vagrant bindler setup`.
1. Clone this repository: `git clone https://github.com/mentels/LINC-environment`
1. Enter the cloned repository and install required plugins: `cd LINC-environment && vagrant plugin bundle`.
1. Run vagrant to setup a machine for LINC development: `vagrant up`. Now wait for vagrant to finish the job.

After running the above steps you will end up with a virtual machine equipped with:
* Erlang,
* Xfce4,
* cloned [LINC](https://github.com/FlowForwarding/LINC-Switch) repository,
* cloned LINC dependencies (optional),
* Wireshark with OpenFlow 1.3 dissector installed.

Usage
=====

Accessing the virtual machine
-----------------------------

Username: vagrant
Password: vagrant

The virtual machine can be accessed in two ways:
* by vagrant,
* by GUI provided by VirtualBox.

Logging in to the machine by vagrant is very easy, you just have to type `vagrant ssh` in the project directory. However you won't get the UI.

VirtualBox provides the console for the VM. After booting the machine you should see its console with the login prompt. Login as vagrant and type `startx` to start Xfce4.

Developing
----------

After booting the machine the LINC code is cloned to `/home/vagrant/development/linc`. By default also LINC dependencies are cloned and you can find them in `/home/vagrant/development/linc-deps`. The entire `/home/vagrant/development` directory is shared with your host in `development` under project root directory. Thanks to that you can use your own editor to edit files.
