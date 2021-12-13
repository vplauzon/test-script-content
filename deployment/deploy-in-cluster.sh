#!/bin/bash

##########################################################################
##  Deploys Integration Test Azure infrastructure solution
##
##  Parameters:
##
##  1- Name of resource group
##  2- JSON / Bicep file path
##  3- Cluster name

rg=$1
templatePath=$2
clusterName=$3

echo "Resource group:  $rg"
echo "Template Path:  $templatePath"
echo "Cluster Name:  $clusterName"
echo "Current directory:  $(pwd)"

echo
echo "Deploying ARM template"

az deployment group create -n "deploy-$(uuidgen)" -g $rg \
    --template-file $templatePath \
    --parameters clusterName=$clusterName
