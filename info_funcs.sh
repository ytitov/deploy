RED='\033[0;31m'
YELLOW='\033[0;33m'
WHITE='\033[0;37m'
NC='\033[0m'


function color {
        echo -e "${1}${2}${NC}\n"
}

function red_text {
        color $RED "$1"
}

function yellow_text {
        color $YELLOW "$1"
}

function warn_text {
        color $YELLOW "$1"
}

function list_item {
        color $WHITE " * $1"
}

warn_text "adding functions wkey, rsync_to_server, create_ssh_key"
function wkey {
  sshpath=$HOME/.ssh/$1;
  warn_text "Contents of $HOME/.ssh: ";
  warn_text "$(ls $HOME/.ssh/*.pub)";
  shift;
  restargs=$@;
  #echo "running eval `ssh-agent -s`"
  red_text "Usage:"
  warn_text "EXAMPLE: './wkey.sh id_key_2 git push git@github.com:ParseSoftware/docker-wordpress-base.git brewbids:brewbids -f'";
  commds="ssh-add $sshpath; $restargs";
  red_text "Running command: $restargs";
  #echo "running command: ssh-agent bash -c $commds"
  #eval `ssh-agent -s`
  ssh-agent bash -c "$commds";
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
###echo ""
###red_text " -----------------------ssh help: -------------------------------------- "
###list_item "https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
###red_text " ---------------------------------------------------------------------- "
###warn_text "Welcome, to update site:"
###warn_text "1. cd brewbids-deploy/BrewBids"
###warn_text "2. do git pull and checkout the branch you need"
###warn_text "3. go down one directory level: cd .."
###warn_text "4. rebuild docker images and deploy"
###list_item "docker image prune -f"
###list_item "docker-compose up -d --no-deps --build nginx wordpress"
###warn_text "to watch logs after restarting and building the container do:"
###list_item "docker-compose logs -f wordpress"
###warn_text "to watch all logs:"
###list_item "docker-compose logs -f"
###warn_text "if site is not running after a minute and is unreachable attempt to restart:"
###list_item "docker-compose restart"

