# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "1024"
  end

  config.vm.define "webserver" do |base|
    base.vm.box = "bento/rockylinux-9"
    base.vm.box_version = "202207.20.0"
    base.vm.hostname = "lon-dev-webserver-1"
  end

  config.vm.provision "shell", inline: <<-SHELL
    if ! command -v ansible-playbook >/dev/null; then
      echo "installing ansible..."
      dnf -yq install ansible-core
    else
      echo "ansible already installed"
    fi

    echo "provisioning..."
    /vagrant/bin/provision vagrant
  SHELL
end
