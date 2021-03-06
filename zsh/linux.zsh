export SSH_ASKPASS_REQUIRE='prefer'

# SSH Agent management
# source https://blog.tinned-software.net/manage-ssh-keys-with-the-ssh-agent/
# Check if the ssh-agent is already running
if [ "$(ps -u $USER | grep ssh-agent | wc -l)" -lt "1" ]; then
  # Start the ssh-agent and redirect the environment variables into a file
  rm -f ~/.ssh/ssh-agent > /dev/null
  ssh-agent -s > ~/.ssh/ssh-agent
fi
# Source existing agent env variables
. ~/.ssh/ssh-agent > /dev/null

# Autoplay animations
alias sxiv='sxiv -a'

export OPEN='xdg-open'

export AUR_PAGER='nvim'

export JAVA_HOME="/usr/lib/jvm/default"
