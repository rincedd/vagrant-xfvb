#!/bin/sh

MODULES="willdurand-nodejs puppetlabs-java puppetlabs-inifile p0deje-display jamesnetherton-google_chrome puppetlabs-ruby"

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

puppet module install puppetlabs-apt --version 1.8.0

for MODULE in ${MODULES} ; do
    install_module ${MODULE}
done
