# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://appdir.net/files/precise32.box"

  config.vm.network :forwarded_port, guest: 80, host: 8085, auto_correct: true
  config.vm.network :forwarded_port, guest: 27017, host: 27117
  config.vm.network :forwarded_port, guest: 3131, host: 3131, auto_correct: true

  config.vm.synced_folder "../sync/www", "/home/vagrant/www", create: true

  #config.ssh.timeout = 60

  config.vm.provision :shell, :path => "bootstrap.sh"
end
