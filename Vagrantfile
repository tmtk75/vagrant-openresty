# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |vb|
    # Give enough horsepower to build without taking all day.
    vb.customize [
      "modifyvm", :id,
      "--memory", "2048",
      "--cpus", "2"
    ]
  end

  #config.vm.box     = "centos65-x86_64-20140116"
  #config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"
  config.vm.box = "puppetlabs/centos-6.6-64-puppet-enterprise"
  #config.vm.box = "puppetlabs/centos-7.0-64-puppet-enterprise"

  config.vm.network :forwarded_port, guest:8000, host:8000, id:"http"
  config.vm.network :private_network, ip:"192.168.1.100"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
  end

  config.vm.provision :shell, :inline => <<-EOH
    cd /vagrant
    /bin/sh ./build.sh
  EOH
 
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "openresty.pp"
    puppet.module_path    = "modules"
  end

end
