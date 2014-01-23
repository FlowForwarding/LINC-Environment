# LINC-Switch attributes
default['linc']['url'] = "git://github.com/FlowForwarding/LINC-Switch"
default['linc']['destination'] = "/home/vagrant/development/linc"


# LINC-Switch dependencies attributes
default['linc']['install_deps'] = false

default['linc']['deps']['of_protocol']['url'] = "git://github.com/FlowForwarding/of_protocol"
default['linc']['deps']['of_protocol']['destination'] = "/home/vagrant/development/linc-deps/of_protocol"

default['linc']['deps']['enetconf']['url'] = "git://github.com/FlowForwarding/enetconf"
default['linc']['deps']['enetconf']['destination'] = "/home/vagrant/development/linc-deps/enetconf"

default['linc']['deps']['of_config']['url'] = "git://github.com/FlowForwarding/of_config"
default['linc']['deps']['of_config']['destination'] = "/home/vagrant/development/linc-deps/of_config"

default['linc']['deps']['pkt']['url'] = "git://github.com/esl/pkt"
default['linc']['deps']['pkt']['destination'] = "/home/vagrant/development/linc-deps/pkt"

# Ping example attributes
default['linc']['install_ping_example'] = false

default['linc']['ping_example']['file'] = "/home/vagrant/ping_example"
default['linc']['ping_example']['interfaces'] = [ "tap0", "tap1" ]
default['linc']['ping_example']['controller_port'] = 6633
