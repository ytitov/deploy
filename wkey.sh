#!/bin/bash
source ./info_funcs.sh
warn_text "adding functions wkey, rsync_to_server, create_ssh_key"
function wkey {
  sshpath=$HOME/.ssh/$1
  warn_text "Contents of $HOME/.ssh: "
  warn_text "$(ls $HOME/.ssh/*.pub)"
  shift
  restargs=$@
  #echo "running eval `ssh-agent -s`"
  red_text "Usage:"
  warn_text "EXAMPLE: './wkey.sh id_key_2 git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f'"
  commds="ssh-add $sshpath && $restargs"
  red_text "Running command: $restargs"
  #echo "running command: ssh-agent bash -c $commds"
  #eval `ssh-agent -s`
  ssh-agent bash -c "$commds"
}

function rsync_to_server {
  echo "rsync to main server, first arg is folder or file no slashes, and second is the ip, given: $1, $2"
  warn_text "rsync_to_server usage: <source folder> <ip address> <name of user>"
  rsync -avz $1 $3@$2:/root
}

function create_ssh_key {
  warn_text "create a key, with name of key as the only argument"
  ssh-keygen -t ecdsa -b 521 -N "" -f ~/.ssh/$1
}

#ssh-agent bash -c 'ssh-add /yourkey; git clone git@github.com:user/project.git'
## example command that works:
## ssh-agent bash -c 'ssh-add /home/deploy/.ssh/id_key_2; git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f'
# example that this script works with:
# ./wkey.sh id_key_2 git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f

