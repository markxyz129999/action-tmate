#
# Description: Connect to Github Actions VM via SSH by using tmate
#

TMATE_SOCK="/tmp/tmate.sock"

# Install tmate on Ubuntu
sudo apt-get update
sudo apt-get install tmate -y

# Generate ssh key
[[ -e ~/.ssh/id_rsa ]] || ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -N ""

# Run deamonized tmate
tmate -S ${TMATE_SOCK} new-session -d
tmate -S ${TMATE_SOCK} wait tmate-ready

# Print connection info
TMATE_SSH=$(tmate -S ${TMATE_SOCK} display -p '#{tmate_ssh}')
TMATE_SSH_RO=$(tmate -S ${TMATE_SOCK} display -p '#{tmate_ssh_ro}')
TMATE_WEB=$(tmate -S ${TMATE_SOCK} display -p '#{tmate_web}')
TMATE_WEB_RO=$(tmate -S ${TMATE_SOCK} display -p '#{tmate_web_ro}')
MSG="
GitHub Actions - tmate session info:
ssh session: ${TMATE_SSH}
web session: ${TMATE_WEB}
ssh session read only: ${TMATE_SSH_RO}
web session read only: ${TMATE_WEB_RO}
Please run 'exit 0' to continue to the next step.
"
echo -e "${MSG}"