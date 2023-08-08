#!/bin/sh -x

# Provide SSH_AUTH_KEY_* via environment variable
for item in `env`; do
   case "$item" in
       SSH_AUTH_KEY*)
            ENVVAR=`echo $item | cut -d \= -f 1`
            printenv $ENVVAR >> /root/.ssh/authorized_keys
            ;;
   esac
done

rc-status; rc-service sshd start; 

tail -f /dev/null
