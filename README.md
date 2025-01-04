# tf_proxmox
Terraform to manage proxmox

## Setup

1. Create user and API token in the proxmox UI and give it `PVEAdmin` permissions
1. Install and Start Tailscale
    ```bash
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list
    apt-get update
    apt-get install tailscale sudo
    tailscale up --ssh --advertise-tags "tag:servers,tag:proxmox"
    tailscale serve --bg https+insecure://localhost:8006
    ```
1. Create a user for terraform to ssh
    ```bash
    useradd -m githubActions
    chsh -s /bin/bash githubActions
    ```
1. Use `visudo -f /etc/sudoers.d/githubActions` to give it the following permissions
    ```bash
    githubActions ALL=(root) NOPASSWD: /sbin/pvesm
    githubActions ALL=(root) NOPASSWD: /sbin/qm
    githubActions ALL=(root) NOPASSWD: /usr/bin/tee /var/lib/vz/*
    githubActions ALL=(root) NOPASSWD: /usr/bin/tee /mnt/pve/*
    ```