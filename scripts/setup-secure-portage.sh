#!/bin/bash -x

sudo emerge -av app-crypt/gentoo-keys

sudo gpg --homedir /var/lib/gentoo/gkeys/keyrings/gentoo/release --with-fingerprint --list-keys

sudo gpg --homedir /var/lib/gentoo/gkeys/keyrings/gentoo/release --edit-key 0xF6CD6C97 trust
sudo gpg --homedir /var/lib/gentoo/gkeys/keyrings/gentoo/release --edit-key 0x17072058 trust
sudo gpg --homedir /var/lib/gentoo/gkeys/keyrings/gentoo/release --edit-key 0x96D8BF6D trust
sudo gpg --homedir /var/lib/gentoo/gkeys/keyrings/gentoo/release --edit-key 0x2D182910 trust
