# -*- mode: ruby -*-
# vi: set ft=ruby :

# https://docs.vagrantup.com.

# Network settings
pref_interface = ['p2p0','en0: Wi-Fi (AirPort)']
vm_interfaces = %x( VBoxManage list bridgedifs | grep ^Name ).gsub(/Name:\s+/, '').split("\n")
pref_interface = pref_interface.map {|n| n if vm_interfaces.include?(n)}.compact
$network_interface = pref_interface[0]

Vagrant.configure("2") do |config|
  ## Choose your base box
  config.vm.box = "dnmgns-debian-7.8.0-amd64-dyn100GB-v0.5"

  # Automatic box update checking.
  config.vm.box_check_update = true

  # Machine name
  config.vm.define "webdev" do |webdev|
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant.
  config.vm.provider "virtualbox" do |vb|

  # Display the VirtualBox GUI when booting the machine
  vb.gui = false

  # Give VM 1/4 system memory & access to all cpu cores on the host
  if RUBY_PLATFORM =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i
    # sysctl returns Bytes and we need to convert to MB
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif RUBY_PLATFORM =~ /linux/
    cpus = `nproc`.to_i
    # meminfo shows KB and we need to convert to MB
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else # sorry Windows folks, I can't help you
    cpus = 2
    mem = 1024
  end

  # Assign additional memory to the guest OS.
  vb.customize ["modifyvm", :id, "--memory", mem]

  # Assign additional cores to the guest OS.
  vb.customize ["modifyvm", :id, "--cpus", cpus]

  # Use more than one virtual CPU in guest OS.
  vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # This setting makes it so that network access from inside the vagrant guest
    # is able to resolve DNS using the hosts VPN connection.
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

  end

  config.vm.network :private_network, ip: "10.10.10.10"
  config.vm.network :forwarded_port, guest: 80, host: 8080
  #config.vm.network :public_network, :bridge => $network_interface

  #ssh conf
  config.ssh.private_key_path = "~/.ssh/vagrant"
  config.ssh.forward_agent = true

  #nfs true or false
  nfs_setting = (RUBY_PLATFORM =~ /linux/ or RUBY_PLATFORM =~ /darwin/)
  
  #www folder
  config.vm.synced_folder "~/dev/", "/var/www/", id: "vagrant-root", :nfs => nfs_setting

  # Provisioning: puppet
  #config.puppet_install.puppet_version = :latest
  config.vm.provision :puppet, run: 'once' do |puppet|
    #puppet.options = "--verbose --debug"
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "base.pp"
    puppet.module_path = "puppet/modules"
  end
end