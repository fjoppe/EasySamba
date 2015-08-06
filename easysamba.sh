#!/bin/sh

if [ -z "$1" ]; then
	echo "Missing parameter"
	echo "Usage: $0 <username>"
	exit 1
fi

if grep -q "guest account" smb.conf; then
	echo "It looks like as if you already changed the Samba configuration with $0, exit"
	exit 1
fi

if ! [ -d /home/$1 ]; then
	echo "The home directory of the user does not exist: /home/$1"
	echo "Did you make a typo, or does the user really not exist?"
	echo "If you want this user, create it first with 'adduser $1'"
	echo "exit"
	exit 1
fi


if ! [ -d /home/$1/share ]; then
	mkdir /home/$1/share
	chown $1:$1 /home/$1/share
	chmod 766 /home/$1/share
	echo "The home directory did not have a shared folder... created it now"
fi

mv smb.conf smb.conf.old
sed "/map to guest = bad user/a\ \ \ guest account = $1" smb.conf.old > smb.conf

SNM=`hostname`

echo "

[public]
        comment = $SNM Share
        browsable = yes
        path = /home/$1/share
        public = yes
        writable = yes
        guest ok = yes
        read only = no
        create mask = 0766
        directory mask = 0766
 "  >> smb.conf

echo "Changed Samba configuration succesfully..."

/etc/init.d/samba restart >/dev/null

SC="file://$SNM"

echo "Shared drive was initialized successully"
echo "On your PC, open Windows Explorer and enter: '$SC'"
echo "ready"

