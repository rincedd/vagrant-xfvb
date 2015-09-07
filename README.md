# Jenkins slave to run browser tests in Chrome
Sets up a VirtualBox VM running a Jenkins slave in Ubuntu Linux that has a Chrome browser available. It is not headless,
so it has to be started on a machine with a GUI.

## Getting started
You will need [VirtualBox][1] and [Vagrant][2] to start the VM. To start the slave, follow these steps:

1. Add a new JNLP slave node to your master Jenkins. Set its home directory to `/home/jenkins`
2. Copy `config.yml.dist` to `config.yml`
3. Set the correct Jenkins master URL in `config.yml`
4. Set the slave's JNLP URL in `config.yml`, this should be something like `<JENKINS_MASTER_URL>/computer/<SLAVE_NAME>/slave-agent.jnlp`
5. Set the slave's secret in `config.yml` as configured in Jenkins
6. Run `vagrant up`
7. The VM should fire up and show a black screen with a cursor. The slave is now waiting for instructions from the master.

[1]: https://www.virtualbox.org
[2]: https://www.vagrantup.com
