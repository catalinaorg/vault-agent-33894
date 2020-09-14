Vagrant.configure("2") do |config|
    config.vm.box = "bruj0/hashitools"
    config.vm.box_version = "0.1"
    config.vm.provision "file", source: "utils/agent-config.hcl", destination: "/home/vagrant/agent-config.hcl"
    config.vm.provision "file", source: "utils/vault", destination: "/home/vagrant/vault"

    config.vm.provision "shell" do |s|
        s.path = "utils/provision.sh"
   end
  end



  