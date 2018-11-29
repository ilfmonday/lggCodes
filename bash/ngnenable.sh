#!/bin/bash
NGN_ENABLE=0
while getopts "s:" arg
do
  case $arg in
    s)
      NGN_ENABLE=$OPTARG
      ;;
  esac
done

echo "NGN_ENABLE:" $NGN_ENABLE
IOA_PATH="/Applications/iOA/iOA.app/"

# set -x
if [ $NGN_ENABLE == 1 ]
then
  sudo chmod -R +xr $IOA_PATH
else
  sudo chmod -R -xr $IOA_PATH
fi

echo "DONE"