Vagrant.configure("2") do |config|

  config.vm.define "win2012" do |win2012|
    win2012.vm.box = "ferventcoder/win2012r2-x64-nocm"
    win2012.vm.hostname = "win2012r2x64"
  end

  config.vm.provision :shell, :path => "shell/vagrant_setup.ps1"
  config.vm.provision :shell, :path => "shell/puppet_module_setup.ps1"

  config.vm.provider :virtualbox do |v, override|
    v.gui = true
    v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
    v.customize ["modifyvm", :id, "--cpus", "2"]
    v.customize ["modifyvm", :id, "--memory", "4024"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--audio", "none"]
    v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--usb", "off"]
    override.vm.network :private_network, ip: "192.168.0.12"
    override.vm.network :private_network, ip: "192.168.33.12"
  end

  config.windows.halt_timeout = 20
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.vm.guest = :windows
  config.vm.communicator = "winrm" if Vagrant::VERSION >= '1.6.0'

  config.vm.network :forwarded_port, guest: 5985, host: 5985, id: "winrm", auto_correct: true
  config.vm.network :forwarded_port, guest: 3389, host: 3389, id: "rdp", auto_correct: true
  config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", auto_correct: true
end
