# EasySamba
Setup a non-secured shared folder with Samba

This script is to setup a quick and dirty shared folder on Linux
without any security restrictions. This is ideal for local Linux installations
such as a Raspberry Pi, or a Virtual Machine run on a (secured) host.

If you're a bit more serious about security, this script will not help you.

How to use this script:

1. Install Samba: sudo apt-get install samba
2. Create a user: sudo adduser yourname
3. Go to samba folder: cd /etc/samba
4. Enter: sudo vi easysamba.sh
5. Press "i" to go to insert mode
5. Copy the easysamba.sh script from Github and paste it into Putty or terminal emulation
6. Hit Escape and enter: ":x" (without double quotes)
7. Enter: chmod u+rwx easysamba.sh
8. Enter: ./easysamba.sh yourname

The script will configure /home/yourname/share as your shared folder.

If you drop files in this share, or create directories, then these items
will receive file permissions, which will never obstruct you.
