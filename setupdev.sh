#!/usr/bin/env bash

########################################
#
# Script to spin up the vagrant dev env
#
########################################

clear
export VAGRANT_CWD=./vagrants
vagrant plugin install vagrant-vbguest
vagrant up 
