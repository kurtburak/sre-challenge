#!/bin/bash

# this is your part to fill
# Params
NAMESPACE=prod
APPS=(payment-provider invoice-app)

# Build images


# Create prod namesapce if not exist
kubectl get ns $NAMESPACE 2> /dev/null
if [ "$?" != "0" ]; then
  kubectl create ns $NAMESPACE
fi

# Deploy applicaitons
for app in "${APPS[@]}"
do
  kubectl apply -f ${app}/deployment.yaml -n $NAMESPACE
  kubectl rollout status deployment ${app} --timeout=60s
  if [ "$?" != "0" ]; then
    echo "Deployment of ${app} was failed!"
  fi
done
