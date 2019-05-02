# How to:
# source <(curl -L tiny.cc/gokubrc)



##########################
#         COLORS         #
##########################
# Colorful manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

RCol='\[\e[0m\]'  # Text Reset
# Regular            Bold                  Underline             High Intensity        BoldHigh Intensity     Background            High Intensity Backgrounds
Bla='\[\e[0;30m\]';  BBla='\[\e[1;30m\]';  UBla='\[\e[4;30m\]';  IBla='\[\e[0;90m\]';  BIBla='\[\e[1;90m\]';  On_Bla='\[\e[40m\]';  On_IBla='\[\e[0;100m\]';
Red='\[\e[0;31m\]';  BRed='\[\e[1;31m\]';  URed='\[\e[4;31m\]';  IRed='\[\e[0;91m\]';  BIRed='\[\e[1;91m\]';  On_Red='\[\e[41m\]';  On_IRed='\[\e[0;101m\]';
Gre='\[\e[0;32m\]';  BGre='\[\e[1;32m\]';  UGre='\[\e[4;32m\]';  IGre='\[\e[0;92m\]';  BIGre='\[\e[1;92m\]';  On_Gre='\[\e[42m\]';  On_IGre='\[\e[0;102m\]';
Yel='\[\e[0;33m\]';  BYel='\[\e[1;33m\]';  UYel='\[\e[4;33m\]';  IYel='\[\e[0;93m\]';  BIYel='\[\e[1;93m\]';  On_Yel='\[\e[43m\]';  On_IYel='\[\e[0;103m\]';
Blu='\[\e[0;34m\]';  BBlu='\[\e[1;34m\]';  UBlu='\[\e[4;34m\]';  IBlu='\[\e[0;94m\]';  BIBlu='\[\e[1;94m\]';  On_Blu='\[\e[44m\]';  On_IBlu='\[\e[0;104m\]';
Pur='\[\e[0;35m\]';  BPur='\[\e[1;35m\]';  UPur='\[\e[4;35m\]';  IPur='\[\e[0;95m\]';  BIPur='\[\e[1;95m\]';  On_Pur='\[\e[45m\]';  On_IPur='\[\e[0;105m\]';
Cya='\[\e[0;36m\]';  BCya='\[\e[1;36m\]';  UCya='\[\e[4;36m\]';  ICya='\[\e[0;96m\]';  BICya='\[\e[1;96m\]';  On_Cya='\[\e[46m\]';  On_ICya='\[\e[0;106m\]';
Whi='\[\e[0;37m\]';  BWhi='\[\e[1;37m\]';  UWhi='\[\e[4;37m\]';  IWhi='\[\e[0;97m\]';  BIWhi='\[\e[1;97m\]';  On_Whi='\[\e[47m\]';  On_IWhi='\[\e[0;107m\]';



#######################################################
#         Command Prompt ... with Error codes         #
#######################################################
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    if [ "$EXIT" != 0 ]; then
        PS1+="${Red}$EXIT${RCol}"      # Add EXIT CODE if exit code non 0
    else
        PS1+=""
    fi

    # If in Python virtual env, add (venvname) into prompt
    if [ "$VIRTUAL_ENV" != "" ]; then
        PS1+="${BBla}($(basename "$VIRTUAL_ENV")${BBla})${RCol} "
    else
        PS+=""
    fi

    PS1+="${BBla}(${Gre}\u${RCol}@${BPur}\h${BBla}) - (${BGre}\w${BBla})${RCol}"

    if [ "$(parse_git_branch)" != "" ]; then
        PS1+=" ${BBla}[${RCol}${BRed}$(parse_git_branch)${RCol}${BBla}]${RCol} "
    else
        PS1+=" "
    fi

    PS1+="$ "
}
export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs



###################################
#         General ALIASES         #
###################################
# Reload Terminal window
alias reload='source ~/.bashrc'

# Repeat last command as sudo
alias fuck='sudo $(history -p \!\!)'

# Colored LS printing sorted BUT directories first
alias ls='ls -p --color --group-directories-first'
# alias ll='ls -hl --color=auto'

# Show hidden files
alias la='ls -Al'

# List dir by file/dir size
alias lsize='ls --sort=size -lhr'

# Edit this file with SublimeText
alias brc="subl ~/.bashrc &"

# Human readable filesizes
alias du="du -h"
alias df="df -h"

alias grepc="grep --color=always"

## Moving around & all that jazz
alias back='cd "$OLDPWD"'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

## Dir shortcuts
alias home='cd ~/'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias images='cd ~/Pictures'
alias programs='cd ~/Programs'
alias videos='cd ~/Videos'

## Xev command - Says what key do I press - to ~/.xbindkeysrc
alias xbind="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

## PIP
# Update all outdated packages
alias pip_update_outdated_user='pip list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U --user'
alias pip_update_outdated='pip list --outdated --format=freeze | grep -v "^\-e" | cut -d = -f 1  | xargs -n1 pip install -U'



#####################################
#         General FUNCTIONS         #
#####################################
# Creates an archive from given directory
function mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
function mktgz() { tar cvzf "${1%%/}.tgz"     "${1%%/}/"; }
function mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Within all files in current and sub-directories remove trailing spaces
function trailing_spaces_remove() {
  find . -type f -exec sed --in-place 's/[[:space:]]\+$//' {} \+
}

# Unpack EVERYTHING
function rozbal(){
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   mkdir "${1%%.*}" && tar xvjf "$1"   -C "${1%%.*}" && cd "${1%%.*}" && clear && ls ;;
            *.tar.gz)    mkdir "${1%%.*}" && tar xvzf "$1"   -C "${1%%.*}" && cd "${1%%.*}" && clear && ls ;;
            *.bz2)       mkdir "${1%.*}"  && bunzip2 "$1"    -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.rar)       mkdir "${1%.*}"  && unrar x "$1"    -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.gz)        mkdir "${1%.*}"  && gunzip "$1"     -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.tar)       mkdir "${1%.*}"  && tar xvf "$1"    -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.tbz2)      mkdir "${1%.*}"  && tar xvjf "$1"   -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.tgz)       mkdir "${1%.*}"  && tar xvzf "$1"   -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.zip)       mkdir "${1%.*}"  && unzip "$1"      -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.Z)         mkdir "${1%.*}"  && uncompress "$1" -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *.7z)        mkdir "${1%.*}"  && 7z x "$1"       -C "${1%.*}"  && cd "${1%.*}"  && clear && ls ;;
            *)           echo "Nepodařilo se rozbalit '$1'" ;;
        esac
    else
        echo "'$1' Není validní soubor pro rozbalení"
    fi
}



########################################
#         ALIASES for PROGRAMS         #
########################################
# Using youtube-dl to download not-yet existing videos to /ST/Evektor/SOFTWARE/BETA_CAE_Youtube_Tutorials
alias youtube-dl_beta="youtube-dl -wic --write-thumbnail --restrict-filenames \
    --output '~/Videos/BETA_CAE_Youtube_Tutorials/%(playlist)s/%(upload_date)s_%(title)s.%(ext)s' \
    --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' \
    --merge-output-format mp4 \
    --write-description https://www.youtube.com/user/betacae/playlists"



########################################
#         GIT and GITHUB stuff         #
########################################
# Lepší log, spuštění přes: git glog
# git config --global alias.glog "log --color --graph --date=short --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %Cgreen(%cd) %C(white)%s %C(bold blue)<%an>%Creset' --abbrev-commit --"
alias git_enable_ssl_local='git config --local http.sslVerify true'
alias git_enable_ssl_global='git config --global http.sslVerify true'
alias git_disable_ssl_local='git config --local http.sslVerify false'
alias git_disable_ssl_global='git config --global http.sslVerify false'

# Show list of project within public github repository of selected user
function ghuserepo() {
    GHUSER=SonGokussj4
    curl -s "https://api.github.com/users/$GHUSER/repos?per_page=100" | grep -o 'git@[^"]*'
}

function git-fatfiles() {
  # Show the first 40 biggest files in active repo in bytes
  # SOURCE: https://stackoverflow.com/questions/1029969/why-is-my-git-repository-so-big
  git rev-list --all --objects | \
    sed -n $(git rev-list --objects --all | \
    cut -f1 -d' ' | \
    git cat-file --batch-check | \
    grep blob | \
    sort -n -k 3 | \
    tail -n40 | \
    while read hash type size; do
         echo -n "-e s/$hash/$((size / 1024 / 1024))M/p ";
    done) | \
    sort -n -k1
}

function git-eradicate() {
  # Make active repository smaller
  # Script is designed to remove info from Git completely (including all info from reflogs).
  # Use with caution.
  # SOURCE: https://stackoverflow.com/questions/1029969/why-is-my-git-repository-so-big
  git filter-branch -f  --index-filter \
      "git rm --force --cached --ignore-unmatch $1" \
       -- --all
  rm -Rf .git/refs/original && \
      git reflog expire --expire=now --all && \
      git gc --aggressive && \
      git prune
}

function git-forget-blob() {
  # Completely remove a file from a git repository history
  #
  # Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
  # GPL licensed (see end of file) * Use at your own risk!
  #
  # Usage:
  #   git-forget-blob file_to_forget
  #
  # Notes:
  #   It rewrites history, therefore will change commit references and delete tags
  test -d .git || { echo "Need to be at base of a git repository" && return 1; }
  git repack -Aq
  ls .git/objects/pack/*.idx &>/dev/null || {
    echo "there is nothing to be forgotten in this repo" && return;
  }
  local BLOBS=( $( git verify-pack -v .git/objects/pack/*.idx | grep blob | awk '{ print $1 }' ) )
  for ref in ${BLOBS[@]}; do
    local FILE="$( git rev-list --objects --all | grep $ref | awk '{ print $2 }' )"
    [[ "$FILE" == "$1" ]] && break
    unset FILE
  done
  [[ "$FILE" == "" ]] && { echo "$1 not found in repo history" && return; }

  git tag | xargs git tag -d
  git branch -a | grep "remotes\/" | awk '{ print $1 }' | cut -f2 -d/ | while read r; do git remote rm $r 2>/dev/null; done
  git filter-branch --index-filter "git rm --cached --ignore-unmatch $FILE"
  rm -rf .git/refs/original/ .git/refs/remotes/ .git/*_HEAD .git/logs/
  (git for-each-ref --format="%(refname)" refs/original/ || echo :) | \
    xargs -n1 git update-ref -d
  git reflog expire --expire-unreachable=now --all
  git repack -q -A -d
  git gc --aggressive --prune=now
}



##########################
#         TWEAKS         #
##########################
# History size from 1,000 to 100,000 commands
HISTFILESIZE=100000000
HISTSIZE=100000

# Don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoreboth  # ignoredups + ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %T  "  # 4665 2019-02-21  history
export HISTIGNORE='history'
# Define color to additional file types
export LS_COLORS=$LS_COLORS:"*.wmv=01;35":"*.wma=01;35":"*.flv=01;35":"*.m4a=01;35"
# Show most popular commands
function top-commands () {
    history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' |sort|uniq -c | sort -rn | head -15
}
# History - delete history commands from <num> to <num>
function histdel(){
  # histdel 4655 4800
  for h in $(seq "$1" "$2" | tac); do
    history -d "$h"
  done
  history -d "$(history | tail -1 | awk '{print $1}')"
}

## TERMINUS (SublimeText) - Enabling Alt-Left/Right moving between words in terminus
if test -n "$TERMINUS_SUBLIME"; then
    bind '"\e[1;3C": forward-word'
    bind '"\e[1;3D": backward-word'
fi

# # Disable history file for current shell session. Can be used within created terminal.
# unset HISTFILE
# Exit without saving history
alias exit_no_history='unset HISTFILE && exit'
# Show open ports
alias ports='netstat -tulanp'
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist



###############################
#         GITEA START         #
###############################
server="http://gitea.servername"
export GITEA_TOKEN=xxx
# List of Commands: https://try.gitea.io/api/swagger#/repository/createCurrentUserRepo


function gitea_create_repo() {
  ###
  ### Gitea api command to create a new repo
  ###

  # COLORS
  local BR='\e[1;31m'  # Bold Red
  local BG='\e[1;32m'  # Bold Green
  local RC='\e[0m'  # Reset Colors

  # Init value
  local PRIVATE=false

  # REPOSITORY NAME
  if [[ "$1" ]]; then
    local reponame_default="$1"
    read -rp "Repository name [$1]: " reponame
    if [[ -z "$reponame" ]]; then reponame="$reponame_default"; fi
  else
    read -rp "Repository name: " reponame
  fi

  # REPOSITORY DESCRIPTION
  if [[ "$2" ]]; then
    local description_default="$2"
    read -rp "Description [$2]: " description
    if [[ -z "$description" ]]; then description="$description_default"; fi
  else
    read -rp "Repository description: " description
  fi

  # REPOSITORY PRIVACY
  if [[ "$3" ]]; then  # user input entered
    local private_default="$3"
    read -rp "Private [$3]: " private  # show ... Private [true]:
    if [[ -z "$private" ]]; then private="$private_default"; fi  # if user just pressed enter, read the input
  else
    read -rp "Private [$PRIVATE]: " private  # if no input entered, read the default [false]
    if [[ -z "$private" ]]; then private="$PRIVATE"; fi  # if user just pressed enter, read the default
  fi

  echo
  echo "Creating new project..."
  echo
  echo "Server response:"
  curl -X POST "${server}/api/v1/user/repos?access_token=$GITEA_TOKEN" \
       -H "accept: application/json" \
       -H "content-type: application/json" \
       -d "{\"name\":\"${reponame}\", \
            \"description\": \"${description}\", \
            \"private\":${private}}"

  # auto_init [true] ... Wheter the repository should be auto/initialized?
  # private   [true] ... Wheter the repository is private
  echo
  echo -e "[ ${BG}SUCCESS${RC} ] Repository was created"
  echo

  clone_url="${server}/${username}/${reponame}"
  echo "URL: '$clone_url"
  echo


  read -rp "Clone into current folder now? [y/N]: " response
  if [[ "$response" =~ ^(yes|y)$ ]]; then
    if [[ $(git clone "$clone_url") ]]; then
    # if [[ $(git -c http.sslVerify=false clone "$clone_url") ]]; then
      # echo "Applying: git config --local http.sslVerify false..."
      # echo "Reason: access does not work for now over https, it is encrypted but verification needs to be disabled..."
      cd "$reponame" || exit
      # git config --local http.sslVerify false || exit
      echo -e "[ ${BG}SUCCESS${RC} ] Repository cloned"
    else
      echo -e "[  ${BR}ERROR${RC}  ] Clonning repository failed..."
    fi
  fi
  echo
  echo "Now create files, you can use cookie or cookiecutter for templates"
}


function gitea_remove_repo() {
  ###
  ### Gitea api command to remove a new repo
  ###

  # COLORS
  local BR='\e[1;31m'  # Bold Red
  local BG='\e[1;32m'  # Bold Green
  local BY='\e[1;33m'  # Bold Yellow
  local RC='\e[0m'  # Reset Colors

  # REPOSITORY NAME
  if [[ "$1" ]]; then
    local reponame_default="$1"
    read -rp "Repository Name [$1]: " reponame
    if [[ -z "$reponame" ]]; then reponame="$reponame_default"; fi
  else
    read -rp "Repository Name: " reponame
  fi

  # USER NAME
  if [[ "$2" ]]; then
    local username_default="$2"
    read -rp "User [$2]: " username
    if [[ -z "$username" ]]; then username="$username_default"; fi
  else
    read -rp "User [$USER]: " username
    if [[ -z "$username" ]]; then username="$USER"; fi  # if user just pressed enter, read the default
  fi

  # Check of existing repo
  check_cmd=$(curl -sX GET "${server}/api/v1/repos/${username}/${reponame}?access_token=$GITEA_TOKEN" | grep "ssh")
  if [[ ! "$check_cmd" ]]; then
    echo -e "[  ${BR}ERROR${RC}  ] Repository not found: '${server}/${username}/${reponame}'"
    return 1
  fi

  # Continue to remove
  echo -e "[ ${BY}WARNING${RC} ] ARE YOU SURE??? This will REMOVE repository: '${server}/${username}/${reponame}'"
  read -rp "To procede, write the repository name again: " reponame_check

  if [[ "$reponame" == "$reponame_check" ]]; then
    curl -sX DELETE "${server}/api/v1/repos/${username}/${reponame}?access_token=$GITEA_TOKEN"
    echo -e "[ ${BG}SUCCESS${RC} ] Repository '$reponame' was removed."
  else
    echo -e "[  ${BR}ERROR${RC}  ] Repository '$reponame' was not removed..."
    echo "Reason: Wrong repository name entered when asked for confirmation."
    return 1
  fi
}


function gitea_list_repo() {
  ###
  ### Gitea api command for listing directories
  ###
  curl -sX GET "${server}/api/v1/repos/search" -H "accept: application/json" \
    | python3 -m json.tool \
    | grep html_url \
    | sed -e 's#[ ",]##g' \
          -e 's#html_url:##' \
          -e 's#https://#http://#'
}


function gitea_connect_here() {
  ###
  ### Gitea api command for creating git remote
  ###
  local BG='\e[1;32m'
  local RC='\e[0m'
  echo "Available repositories: "
  gitea_list_repo
  echo
  read -rp "Full address of repository: " repoaddress
  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
    echo "Skipping init, already repo"
  else
    git init
  fi
  echo
  # Check if remote 'gitea' repo already exists
  if [[ "$(git remote | grep gitea)" ]]; then
    echo "Setting $repoaddress to 'gitea' repository"
    git remote set-url gitea "$repoaddress"
  else
    echo "Adding new repository name: 'gitea'"
    git remote add gitea "$repoaddress"
    echo -e "[ ${BG}Success${RC} ] "
    echo
    echo "Here is an info about repository:"
    git remote show gitea
  fi
}


function git_remote_all() {
  gitea_remote_all
}

function gitea_remote_all() {
  if ! [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]; then
    echo "Not a git repository. Aborting..."
    return 1
  fi
  # If remote repository 'all' exists, remove it
  if [[ "$(git remote | grep all)" ]]; then
    git remote remove all
  fi
  # Extract all existing remote repositories, connect: Name_____address
  all_repos=$(git remote -v | sed 's#[[:space:]]#_____#' | cut -d ' ' -f1 | uniq)
  # Extract first repo's name that will be the default (fetch)
  first_repo=$(echo $all_repos | cut -d ' ' -f1 | cut -d'_' -f6-)
  # Add new remote repositoy 'all' with that first repo's url
  git remote add "all" "$first_repo"
  # Now iterate over $all_repos and add them to 'all'
  for item in ${all_repos[@]}; do
    repo=$(echo "$item" | cut -d'_' -f6-)
    git remote set-url --add --push "all" "$repo"
  done
  echo
  echo "Created new 'all' remote repository with (push) nodes from all existing repos."
  echo
  git remote show "all"
}

#############################
#         GITEA END         #
#############################



#########################
#         PYENV         #
#########################
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
