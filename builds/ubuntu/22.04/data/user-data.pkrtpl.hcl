#cloud-config
autoinstall:
  version: 1
  early-commands:
  # Stop ssh for packer as it thinks it timed out (workaround)
  - sudo systemctl stop ssh
  locale: en_US
  network:
    network:
      version: 2
      ethernets:
        ens192:
          dhcp4: true
  storage:
    layout:
      name: lvm
  identity:
    hostname: ubuntu-packer
    username: ${guest_username}
    password: ${guest_password_encrypted}
  ssh:
    install-server: yes
    allow-pw: true
  user-data:
    disable_root: false
  late-commands:
    - echo '${guest_username} ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/${guest_username}
    - sudo lvm lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
    - sudo resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv
  early-commands:
    - sudo systemctl stop ssh