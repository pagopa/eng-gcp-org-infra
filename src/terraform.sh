#!/bin/bash
set -e

#
# 💡 How to use
# sh terraform.sh apply
# sh terraform.sh apply
#

ACTION=$1

SCRIPT_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CURRENT_DIRECTORY="$(basename "$SCRIPT_PATH")"
shift 1
other="$*"

echo "[INFO] This is the current directory: ${CURRENT_DIRECTORY}"

if [ -z "$ACTION" ]; then
  echo "[ERROR] Missed ACTION: init, apply, plan"
  exit 0
fi

#
# 🏁 Source & init shell
#

# project set
gcloud config set project organization-443016

# if using cygwin, we have to transcode the WORKDIR
if [[ $WORKDIR == /cygdrive/* ]]; then
  WORKDIR=$(cygpath -w $WORKDIR)
fi

#
# 🌎 Terraform
#
if echo "init plan apply refresh import output state taint destroy" | grep -w "$ACTION" > /dev/null; then
  if [ "$ACTION" = "init" ]; then

    # init terraform backend
    echo "[INFO] 🎬 init tf"
    terraform init \
      -reconfigure \
      -backend-config="00_backend.tfvars"

  elif [ "$ACTION" = "output" ] || [ "$ACTION" = "state" ] || [ "$ACTION" = "taint" ]; then

    # init terraform backend
    echo "[INFO] 🎬 init tf"
    terraform init \
      -reconfigure \
      -backend-config="00_backend.tfvars"

    terraform "$ACTION" "$other"

  else

    # init terraform backend
    echo "[INFO] 🎬 init tf"
    terraform init \
      -reconfigure \
      -backend-config="00_backend.tfvars"

    echo "[INFO] ⌛️ run tf with: ${ACTION} and other: >${other}<"
    terraform "${ACTION}" \
      -compact-warnings \
      -var-file="terraform.tfvars" \
      $other

    echo "[INFO] ✅ completed tf with: ${ACTION} and other: >${other}<"

  fi
else

    echo "[ERROR] 🚧 ACTION not allowed."
    exit 1

fi
