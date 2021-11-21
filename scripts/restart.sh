#!/bin/bash

SUDO_ENAB=$(sudo -nl | grep service)

if [[ "x$SUDO_ENAB" = "x" ]]
then
    echo Time to restart the service.
    echo
    echo Add the following to the system sudoers file to allow this script to
    echo allow the deploy script to restart the service automatically:
    echo
    echo snekinfo   rarity=NOPASSWD:/sbin/service snekinfo restart
    echo
else
    sudo service snekinfo restart
fi
