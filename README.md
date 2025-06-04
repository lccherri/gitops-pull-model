# RHACM + OpenShift GitOps Pull Model

GitOps Pull Model is a deployment strategy where application configurations are centrally managed on the ACM Hub Cluster. Managed clusters independently pull these configurations directly from a Git repository, ensuring decentralized control and streamlined operations.

This approach improves scalability, reliability, and resilience by eliminating single points of failure and distributing workloads across managed clusters.

This demonstration provides all the necessary resources to implement the GitOps Pull Model effectively.

## Prerequisites

Before you begin, ensure the following requirements are met:

1. OpenShift Container Platform version 4.16 or later.
2. Red Hat Advanced Cluster Management for Kubernetes (RHACM) version 2.13 or later.

## Installing RHACM

To install RHACM, execute the following command:

```bash
# Run the ACM installation script
sh ./00-rhacm/acm-install.sh
```

This script installs RHACM operator on your cluster, enabling centralized management and GitOps capabilities.

Access the OpenShift console and navigate to **Installed Operators > Advanced Cluster Management for Kubernetes**. Here, you should see the MultiClusterHub resource with its status displayed as **Running**.

![MultiClusterHub Status](99-assets/multiclusterhubs.png){ style="border: 1px solid gray;" }

## Configuring Policies

After installing RHACM, apply the required policies to set up the GitOps environment:

```bash
oc create namespace policies
oc apply -f ./00-rhacm/02-policies -n policies
```

## Configuring Applications

With OpenShift GitOps configured on both the Hub Cluster and managed clusters, create the ApplicationSet to distribute workloads across managed clusters.

Apply this configuration on the RHACM Hub Cluster:

```bash
oc apply -f ./01-gitops/00-applications -n gitops-hub
```
