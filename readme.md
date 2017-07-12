## Instructions

1. Burn the controller image to a card
2. Add a `ssh` file to the boot folder
3. Create a hosts file
4. Run `ansible-playbook -i hosts -l controllers clusterhat.yml`
5. SSH onto the controller
6. git clone this repository
7. Create a hosts file
6. Run `ansible-playbook -i hosts -l nodes clusterhat.yml`

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