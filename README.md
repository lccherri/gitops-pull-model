# RHACM + OpenShift GitOps Pull Model

GitOps Pull Model is a deployment strategy where application configurations are centrally managed on the ACM Hub Cluster. Managed clusters autonomously pull these configurations directly from the Git repository, ensuring decentralized control.

This model enhances scalability, reliability, and resilience by eliminating single points of failure and distributing workloads across managed clusters.

This demonstration provides all the necessary resources to implement the GitOps Pull Model effectively.

## Prerequisites

Ensure the following requirements are met before proceeding:

1. OpenShift Container Platform version 4.16 or later.
2. Red Hat Advanced Cluster Management for Kubernetes (RHACM) version 2.13 or later.

## Installing RHACM

To install RHACM, run the following command:

```bash
# Execute the ACM installation script
sh ./00-rhacm/acm-install.sh
```

This script sets up RHACM on your cluster, enabling centralized management and GitOps functionality.

## Configuring Policies

Once RHACM is installed, apply the necessary policies to configure the GitOps environment:

```bash
oc create namespace policies
oc apply -f ./00-rhacm/02-policies -n policies
```


```bash
oc apply -f ./01-gitops/00-applications -n gitops-hub
```