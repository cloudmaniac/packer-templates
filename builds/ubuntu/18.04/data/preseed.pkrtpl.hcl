## Options to set on the command line
d-i debian-installer/locale string en_US.utf8

# Disable automatic (interactive) keymap detection.
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/xkb-keymap select us

d-i console-setup/layout string us

# d-i netcfg/get_hostname string packer-ubuntu-bionic-beaver
# d-i netcfg/get_domain string unassigned-domain

d-i time/zone string Europe/Paris
d-i clock-setup/utc-auto boolean true
d-i clock-setup/utc boolean true

d-i kbd-chooser/method select us

d-i netcfg/wireless_wep string

d-i base-installer/kernel/override-image string linux-server

d-i debconf debconf/frontend select Noninteractive

d-i pkgsel/install-language-support boolean false
tasksel tasksel/first multiselect standard, ubuntu-server

### Partitioning
## Partitioning example
# If the system has free space you can choose to only partition that space.
# This is only honoured if partman-auto/method (below) is not set.
# Alternatives: custom, some_device, some_device_crypto, some_device_lvm.
#d-i partman-auto/init_automatically_partition select biggest_free

# Alternatively, you may specify a disk to partition. If the system has only
# one disk the installer will default to using that, but otherwise the device
# name must be given in traditional, non-devfs format (so e.g. /dev/hda or
# /dev/sda, and not e.g. /dev/discs/disc0/disc).
# For example, to use the first SCSI/SATA hard disk:
#d-i partman-auto/disk string /dev/sda
# In addition, you'll need to specify the method to use.
# The presently available methods are:
# - regular: use the usual partition types for your architecture
# - lvm:     use LVM to partition the disk
# - crypto:  use LVM within an encrypted partition
d-i partman-auto/method string lvm

# If one of the disks that are going to be automatically partitioned
# contains an old LVM configuration, the user will normally receive a
# warning. This can be preseeded away...
d-i partman-lvm/device_remove_lvm boolean true
# The same applies to pre-existing software RAID array:
d-i partman-md/device_remove_md boolean true
# And the same goes for the confirmation to write the lvm partitions.
d-i partman-lvm/confirm boolean true

# For LVM partitioning, you can select how much of the volume group to use
# for logical volumes.
d-i partman-auto-lvm/guided_size string max
#d-i partman-auto-lvm/guided_size string 10GB
#d-i partman-auto-lvm/guided_size string 50%

# Defining the name of the VG
d-i partman-auto-lvm/new_vg_name string system

# You can choose one of the three predefined partitioning recipes:
# - atomic: all files in one partition
# - home:   separate /home partition
# - multi:  separate /home, /usr, /var, and /tmp partitions
d-i partman-auto/choose_recipe select atomic

# Or provide a recipe of your own...
# If you have a way to get a recipe file into the d-i environment, you can
# just point at it.
#d-i partman-auto/expert_recipe_file string /hd-media/recipe

# If not, you can put an entire recipe into the preconfiguration file in one
# (logical) line. This example creates a small /boot partition, suitable
# swap, and uses the rest of the space for the root partition:
#d-i partman-auto/expert_recipe string                         \
#      boot-root ::                                            \
#              40 50 100 ext3                                  \
#                      $primary{ } $bootable{ }                \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ /boot }                     \
#              .                                               \
#              500 10000 1000000000 ext3                       \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ / }                         \
#              .                                               \
#              64 512 300% linux-swap                          \
#                      method{ swap } format{ }                \
#              .

# If you just want to change the default filesystem from ext3 to something
# else, you can do that without providing a full recipe.
#d-i partman/default_filesystem string ext4

# The full recipe format is documented in the file partman-auto-recipe.txt
# included in the 'debian-installer' package or available from D-I source
# repository. This also documents how to specify settings such as file
# system labels, volume group names and which physical devices to include
# in a volume group.

# This makes partman automatically partition without confirmation, provided
# that you told it what to do using one of the methods above.
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

## Partitioning using RAID
# The method should be set to "raid".
#d-i partman-auto/method string raid
# Specify the disks to be partitioned. They will all get the same layout,
# so this will only work if the disks are the same size.
#d-i partman-auto/disk string /dev/sda /dev/sdb

# Next you need to specify the physical partitions that will be used. 
#d-i partman-auto/expert_recipe string \
#      multiraid ::                                         \
#              1000 5000 4000 raid                          \
#                      $primary{ } method{ raid }           \
#              .                                            \
#              64 512 300% raid                             \
#                      method{ raid }                       \
#              .                                            \
#              500 10000 1000000000 raid                    \
#                      method{ raid }                       \
#              .

# Last you need to specify how the previously defined partitions will be
# used in the RAID setup. Remember to use the correct partition numbers
# for logical partitions. RAID levels 0, 1, 5, 6 and 10 are supported;
# devices are separated using "#".
# Parameters are:
# <raidtype> <devcount> <sparecount> <fstype> <mountpoint> \
#          <devices> <sparedevices>

#d-i partman-auto-raid/recipe string \
#    1 2 0 ext3 /                    \
#          /dev/sda1#/dev/sdb1       \
#    .                               \
#    1 2 0 swap -                    \
#          /dev/sda5#/dev/sdb5       \
#    .                               \
#    0 2 0 ext3 /home                \
#          /dev/sda6#/dev/sdb6       \
#    .

# For additional information see the file partman-auto-raid-recipe.txt
# included in the 'debian-installer' package or available from D-I source
# repository.

# This makes partman automatically partition without confirmation.
d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

d-i partman-md/confirm_nooverwrite boolean true
d-i partman-lvm/confirm_nooverwrite boolean true

## Controlling how partitions are mounted
# The default is to mount by UUID, but you can also choose "traditional" to
# use traditional device names, or "label" to try filesystem labels before
# falling back to UUIDs.
#d-i partman/mount_style select uuid

d-i partman-partitioning/no_bootable_gpt_biosgrub boolean false
d-i partman-partitioning/no_bootable_gpt_efi boolean false
d-i partman-efi/non_efi_system boolean true

# Default user
d-i passwd/user-fullname string Hashicorp ${guest_username}
d-i passwd/username string ${guest_username}
d-i passwd/user-password password ${guest_password}
d-i passwd/user-password-again password ${guest_password}
d-i user-setup/encrypt-home boolean false
d-i user-setup/allow-password-weak boolean true

# Upgrade packages after debootstrap? (none, safe-upgrade, full-upgrade)
# (note: set to none for speed)
d-i pkgsel/upgrade select none

d-i grub-installer/only_debian boolean true
#d-i grub-installer/with_other_os boolean true
d-i grub-installer/timeout string 0
d-i grub-installer/bootdev string default

d-i pkgsel/update-policy select none

choose-mirror-bin mirror/http/proxy string

# Minimum packages
d-i pkgsel/include string open-vm-tools openssh-server ntp
#d-i preseed/late_command string in-target apt-get install -y --install-recommends linux-image-virtual linux-tools-virtual linux-cloud-tools-virtual

# Add user to sudoers and additional packages
# Apparently the 'echo' command doesn't work if we specify 'in-target' so I removed it
d-i preseed/late_command string \
    echo '${guest_username} ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/${guest_username} ; \
    in-target chmod 440 /etc/sudoers.d/${guest_username} ; \
    in-target apt-get install -y --install-recommends linux-image-virtual linux-tools-virtual linux-cloud-tools-virtual ;

d-i finish-install/reboot_in_progress note
