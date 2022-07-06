#!/bin/bash

# this is your part to fill
# Params
NAMESPACE=prod
APPS=(invoice-app payment-provider)

# Build images


# Create prod namesapce if not exist
kubectl get ns $NAMESPACE 2> /dev/null
if [ $? -ne 0 ]; then
  kubectl create ns $NAMESPACE
fi

# Deploy applicaitons
for app in "${APPS[@]}"
do
  kubectl apply -f ${app}/deployment.yaml -n $NAMESPACE
done
