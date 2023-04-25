#!/bin/bash

# A helper script to help preparing yaml files for development teams
# Input: team name, namespace(s) name
# Output: gitlab-ci file and namespace directory and files

echo -e "\n### Moin. ###\n"
echo "What's the team name (no blanks or special characters please):"
read TEAM
echo "This will prepare files for the << $TEAM >> team"
echo "After Merge Request and a successful pipeline, the KUBECONFIG will be created"

echo "Creating << $TEAM >> directory..."
mkdir -p namespaces/$TEAM
VERTICAL='none'
echo "Directory << namespaces/$TEAM >> created."
while true ; do
  echo "Please provide following information:"
  echo "Environment: (dev, int, rc or preprod) "
  read ENVIRONMENT
  echo "Project: "
  read PROJECT
  echo "Vertical (leave empty if not needed): "
  read VERTICAL
  VERTICAL=${VERTICAL:-none}
  if [ $VERTICAL == 'none' ]; then NAMESPACE=$ENVIRONMENT-$PROJECT; else NAMESPACE=$ENVIRONMENT-$PROJECT-$VERTICAL; fi
  echo 'Setting default quotas: requests.cpu: "1" requests.memory: 1Gi limits.cpu: "2" limits.memory: 2Gi"'
  echo "Change it if needed"
  echo "Creating gitlab-ci yaml file for the << $TEAM >> team..."
  cat > namespaces/$TEAM/namespace-$NAMESPACE.yaml << EOF
---
apiVersion: v1
kind: Namespace
metadata:
  name: $NAMESPACE
  labels:
    net.ista.isdp.team: $TEAM
    net.ista.isdp.app: $PROJECT
    net.ista.isdp.environment: $ENVIRONMENT
    team: $TEAM
EOF
  echo "Create another? (any/n)"
  read ANSWER
  if [ "0"$ANSWER == '0n' ] ; then echo "It's enough, right" && break ; else echo "Creating another"; fi
done

echo "File(s) created and looks like this:"
cat namespaces/$TEAM/*
echo "We hope you like it."
