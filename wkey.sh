sshpath=$HOME/.ssh/$1
shift
restargs=$@
#echo "running eval `ssh-agent -s`"
echo "EXAMPLE: './wkey.sh id_key_2 git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f'"
commds="ssh-add $sshpath; $restargs"
echo "running command: ssh-agent bash -c $commds"
#eval `ssh-agent -s`
ssh-agent bash -c "$commds"
#ssh-agent bash -c 'ssh-add /yourkey; git clone git@github.com:user/project.git'
## example command that works:
## ssh-agent bash -c 'ssh-add /home/deploy/.ssh/id_key_2; git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f'
# example that this script works with:
# ./wkey.sh id_key_2 git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f

