## Instructions

1. Burn the controller image to a card
2. Add a `ssh` file to the boot folder
3. Create a hosts file
4. Run `ansible-playbook -i hosts -l controllers clusterhat.yml`
5. SSH onto the controller
6. git clone this repository
7. Run `ansible-playbook -l nodes clusterhat.yml`

## Sample host file

This will work if you have zeroconf networking on your host machine.

```
[controllers]
controller

[nodes]
p[1:4]
```

## Custom settings

There are some custom settings in roles/common/vars/main.yml to do with locale. Change them to your location.

The `github` value is used to download the public key for using with ssh. You can upload your keys to your account at https://github.com/settings/keys and then change the value of `github` to your username and the script will use your key for the controller.

## Swarm Playbook

This sets up a docker swarm with the controller as the manager, and the nodes as workers. Run on the controller.

    $ ansible-playbook -i hosts swarm.yml

## Other things to do

Install Docker Swarm Visualizer. Creates a swarm visualization at http://controller.local:8090/

    $ docker service create --name=viz --publish=8090:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock alexellis2/visualizer-arm:latest

Alex Ellis (@alexellis) has a great project FaaS https://github.com/alexellis/faas which runs Functions as a Service on a docker swarm.

    $ git clone https://github.com/alexellis/faas
    $ cd faas
    $ git checkout 0.5.6b-alpha
    $ ./deploy_stack.armhf.sh