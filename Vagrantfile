Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "private_network", ip: "192.168.33.34"
  config.vm.synced_folder "./", "/var/www/html", :owner => "www-data", :group => "www-data", type: "rsync", rsync__exclude: "./vendor"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "bbe-test-task"
    vb.gui = false
    vb.cpus = 1
    vb.memory = "4096"
  end

  config.trigger.after :up, :reload do |trigger|
    trigger.info = "Booting project..."
    trigger.run_remote = {inline: "/var/www/html/etc/sh/setup.sh"}
  end

  config.vm.provision "file", source: "./vagrant/.ssh/id_rsa.pub", destination: "~/.ssh/me.pub"

  config.vm.provision "shell", inline: <<-SHELL
    cat /home/vagrant/.ssh/me.pub >> /home/vagrant/.ssh/authorized_keys
    /var/www/html/etc/sh/provision.sh
  SHELL
end
