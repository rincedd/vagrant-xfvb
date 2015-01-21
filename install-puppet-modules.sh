#!/bin/sh

MODULES="puppetlabs-nodejs puppetlabs-java"

install_module() {
    MODULE="$1"
    puppet module list | grep ${MODULE}
    if [ $? -ne 0 ]; then
        puppet module install ${MODULE}
    else
        echo "Puppet module $MODULE already installed."
    fi
}

mkdir -p /etc/puppet/modules

for MODULE in ${MODULES} ; do
    install_module ${MODULE}
done
