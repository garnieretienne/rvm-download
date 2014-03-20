# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "ubuntu", :primary => true do |host|

    host.vm.box = "precise64"
    host.vm.box_url = "http://files.vagrantup.com/precise64.box"

    bootstrap_script = <<-SCRIPT
      export DEBIAN_FRONTEND=noninteractive
      sudo apt-get --assume-yes update
      sudo apt-get --assume-yes install git curl
      git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
      echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
      echo 'eval "$(rbenv init -)"' >> ~/.profile
      mkdir -p ~/.rbenv/plugins
      ln -s /vagrant ~/.rbenv/plugins/rvm-download
    SCRIPT

    host.vm.provision "shell", :inline => bootstrap_script, :privileged => false
  end
end
