#!/bin/bash

# Exit the scripts directory
sh scripts/clone_karamel_chef.sh

# Copy correct Vagrantfile/cluster
if [ "$1" == "ubuntu" ]; then
  sleep 5m
  rm -rf $HOME/.berkshelf

  cp templates/Vagrantfile-ubuntu karamel-chef/Vagrantfile
  cp templates/cluster-ubuntu karamel-chef/cluster.yml
else
  # Centos
  cp templates/Vagrantfile-centos karamel-chef/Vagrantfile
  cp templates/cluster-centos karamel-chef/cluster.yml
fi

sed -i "s/test_platform/$BUILD_NUMBER/g" karamel-chef/cluster.yml

# Execute the tests
cd karamel-chef
sh ./test.sh
