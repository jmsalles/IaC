Install qemu-kvm:

sudo dnf install qemu-kvm libvirt libguestfs-tools virt-install rsync libvirt-devel ruby-devel gcc qemu-kvm make


Enable and start the libvirt daemon:

sudo systemctl enable --now libvirtd