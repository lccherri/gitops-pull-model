#!/bin/bash
set -e

echo "Installing the ACM operator..."

# Creates the Operator Group and Subscription for ACM
oc create namespace open-cluster-management
oc create -f ./00-rhacm/00-subscription/00-operatorgroup.yaml
oc apply -f ./00-rhacm/00-subscription/01-subscription.yaml

# Wait for the ACM Operator to be installed
while [[ $(oc get clusterserviceversions.operators.coreos.com -l 'operators.coreos.com/advanced-cluster-management.open-cluster-management=' -n open-cluster-management --no-headers 2>/dev/null | wc -l) -lt 1 ]]; do
        sleep 2
done

oc wait clusterserviceversions.operators.coreos.com \
        -l 'operators.coreos.com/advanced-cluster-management.open-cluster-management=' \
        -n open-cluster-management \
        --for=jsonpath='{.status.phase}'=Succeeded \
        --timeout=600s

echo "Creating the Multi Cluster Hub..."

# Creates the MultiClusterHub CR
oc apply -f ./00-rhacm/01-configuration/00-multiclusterhub.yaml

# Wait for the MCH to be provisioned
oc wait multiclusterhubs.operator.open-cluster-management.io multiclusterhub \
        -n open-cluster-management \
        --for=condition=Complete=True \
        --timeout=600s

echo "Finished!"
