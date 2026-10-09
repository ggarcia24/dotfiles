#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o noclobber
set -o pipefail
# set -o xtrace


# Source - https://stackoverflow.com/a/23138950
# Posted by Giacomo1968, modified by community. See post 'Timeline' for change history
# Retrieved 2026-10-09, License - CC BY-SA 3.0

LOCK_NAME="WORK_CODE_BACKUP"
LOCK_DIR='/tmp/'${LOCK_NAME}.lock
PID_FILE=${LOCK_DIR}'/'${LOCK_NAME}'.pid'

if mkdir ${LOCK_DIR} 2>/dev/null; then
  # If the ${LOCK_DIR} doesn't exist, then start working & store the ${PID_FILE}
  echo $$ > ${PID_FILE}
  # Source - https://stackoverflow.com/a/23141269
  # Posted by Keith Reynolds, modified by community. See post 'Timeline' for change history
  # Retrieved 2026-10-09, License - CC BY-SA 3.0

  # Garbage clean up with trap given any of these SIGNALS
  # INT   Pressing Control-C      kill -2 pid
  # TERM  Termination signal      kill -15 pid
  # EXIT  Shell exit
  trap 'rm -rf "$LOCK_DIR"; exit $?' INT TERM EXIT

  echo -e "\n==== STARTING WORK CODE BACKUP: $(date) ====\n"

  set -e # always immediately exit upon error

  # directory config. ending slashes are important!
  src_dir="$HOME/Projects/"
  dest_dir="$HOME/Projects_Backup/"

  # run the sync
  rsync -avzr --delete --links --perms --executability --times \
    --filter=':- .gitignore' \
    --exclude='node_modules' \
    --exclude='.DS_Store' \
    --chmod='F-w' \
    "$src_dir" "$dest_dir"
  echo -e "\n==== END WORK CODE BACKUP: $(date) ====\n"
  exit
else
    if [ -f ${PID_FILE} ] && kill -0 $(cat ${PID_FILE}) 2>/dev/null; then
        # Confirm that the process file exists & a process
        # with that PID is truly running.
        echo "Running [PID "$(cat ${PID_FILE})"]" >&2
        exit
    else
        # If the process is not running, yet there is a PID file--like in the case
        # of a crash or sudden reboot--then get rid of the ${LOCK_DIR}
        rm -rf ${LOCK_DIR}
        exit
    fi
fi
