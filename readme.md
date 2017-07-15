## Instructions

1. Burn the controller image to a card
2. Add a `ssh` file to the boot folder
3. Create a hosts file
4. Run `ansible-playbook -i hosts -l controllers clusterhat.yml`
5. SSH onto the controller
6. `git clone https://github.com/distantcam/ansible-rpi-playbooks.git`
7. `clusterhat on`
8. Run `ansible-playbook -l nodes clusterhat.yml`

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

    $ ssh-copy-id controller
    $ ansible-playbook swarm.yml

## Other things to do

Install Docker Swarm Visualizer. Creates a swarm visualization at http://controller.local:8090/

    $ docker service create --name=viz --publish=8090:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock alexellis2/visualizer-arm:latest

Alex Ellis (@alexellis) has a great project FaaS https://github.com/alexellis/faas which runs Functions as a Service on a docker swarm.

    $ git clone https://github.com/alexellis/faas
    $ cd faas
    $ git checkout 0.5.6b-alpha
    $ ./deploy_stack.armhf.sh

Alex also has a demo project for the blinkt displays.

    $ docker service create --name progressbar --mount type=bind,source=/sys,destination=/sys --mode global --constraint node.role==worker alexellis2/progress-blinkt:blue

Docker Swarm Monitor https://github.com/StefanScherer/swarm-monitor

    $ docker service create --name monitor --mode global --restart-condition any --constraint node.role==worker --mount type=bind,src=/sys,dst=/sys --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock stefanscherer/monitor:latest

## Remote edit code in Visual Studio Code

I'm a Windows developer, and I like using Visual Studio Code to edit files. There's a really neat way to edit files from the Raspberry Pi remotely in Visual Studio Code.

In Visual Studio Code, install the plugin Remote VSCode https://marketplace.visualstudio.com/items?itemName=rafaelmaiolla.remote-vscode Add the required settings to your user settings.

```
{
    "remote.port": 52698,
    "remote.onstartup": true
}
```

Now ssh into your raspberry pi and create a ssh tunnel with the rmate port

    $ ssh -R 52698:localhost:52698 pi@controller.local

Now install rmate from https://github.com/aurora/rmate

    $ sudo wget -O /usr/local/bin/rmate https://raw.github.com/aurora/rmate/master/rmate
    $ sudo chmod a+x /usr/local/bin/rmate

And finally you should be able to edit a file using rmate.

    $ rmate file.txt