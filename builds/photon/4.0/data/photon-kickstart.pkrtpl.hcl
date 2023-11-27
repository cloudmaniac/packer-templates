{
    "hostname": "packer-photon",
    "password":
        {
            "crypted": true,
            "text": "${guest_password_encrypted}"
        },
    "disk": "/dev/sda",
    "packages": ["minimal", "linux", "initramfs", "vim"],
    "postinstall": [
                    "#!/bin/sh",
                    "sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config",
                    "systemctl restart sshd.service"
                    ]
}