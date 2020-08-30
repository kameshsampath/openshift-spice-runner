# Kubernetes Demo Project Template

The Ansible Runner project to deploy operators and their related Custom Resources to OpenShift.

The role [OpenShift Spices](https://github.com/kameshsampath/ansible-role-openshift-spices), allows install and configure the following software components using operators:

- [*] Red Hat OpenShift Serverless both Serving and Eventing

- [*] Red Hat OpenShift Pipelines

- [*] [Argo CD](https://argoproj.github.io/argo-cd/)

- [*] Red Hat OpenShift Service Mesh

- [*] [Strimzi Kafka](https://strimzi.io)

- [*] [Red Hat Advanced Cluster Management for Kubernetes](https://www.redhat.com/en/technologies/management/advanced-cluster-management)

- [ ] [Skupper](https://skupper.io)

- [*] [Apache Camel-K](https://camel.apache.org/docs/#camel-k)

- [*] [Eclipse Che](https://www.eclipse.org/che/)

## Pre-requsites

- [Docker](https://docs.docker.com/get-docker/) or [podman](https://podman.io/)
- [OpenShift  4 Cluster](try.openshift.com)
- [openshift cli `oc`](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)

__NOTE__: Based on your configuration you might need other tools like:

- [Tekton CLI](https://github.com/tektoncd/cli)
- [Knative Client](https://github.com/knative/client)
- [Argo CD CLI](https://argoproj.github.io/argo-cd/cli_installation/)

## Clone sources

```shell
git clone https://github.com/openshift-spice-runner
export REPO_HOME=`pwd`/openshift-spice-runner
```

## Configuration

All configuration are done using `$REPO_HOME/.cluster/.env`:

| Variable | Description | Default
| -------- | ----------- | -------

| *RUNNER_PLAYBOOK* | The cluster configuration playbook, this file will be searched in $REPO_HOME/project folder. Just filename is suffice. | playbook.yml |

### Playbook Variables

The role variables can be passed using the `$REPO_HOME/cluster/env/extravars`.

Copy the file and update it as needed:

```shell
cp $REPO_HOME/cluster/env/extravars.example $REPO_HOME/cluster/env/extravars
```

Check [kameshsampath.openshift_app_spices](https://github.com/kameshsampath/ansible-role-openshift-spices) for list of configuration parameters.

### OpenShift Cluster Inventory

The inventory file `$REPO_HOME/hosts`, allows the play tobe run across OpenShift clusters:

#### .hosts.example

```ini
; Example Google Cloud
gcp ansible_host=localhost kubeconfig=/runner/inventory/gcp.kubeconfig cloud_profile=gcp

; Example AWS
aws ansible_host=localhost kubeconfig=/runner/inventory/aws.kubeconfig cloud_profile=aws

; Example Azure
azr ansible_host=localhost kubeconfig=/runner/inventory/azr.kubeconfig cloud_profile=azr
```

The above example shows the sample configuration(s) for three clouds GCP, AWS and Azure. Each cloud is configured the format:

```text
<cloud-alias> ansible_host=localhost kubeconfig=/runner/inventory/<kubeconfig file> cloud_profile <gcp|aws|azr>
```

- *cloud-alias*: The host alias for the cloud to used and logged by ansible
- *ansible_host*: The `ansible_host` is always set to `localhost` as the play will run within the docker container and connect to cluster using API
- *kubeconfig*: The Cloud specific `kubeconfig` file path. Just update the file name as needed. The `$REPO_HOME/inventory` is mounted as `/runner/inventory`, which makes the file path `/runner/inventory` to be same for all clouds

Copy the file and update it as needed:

```shell
cp $REPO_HOME/cluster/inventory/hosts.example $REPO_HOME/cluster/inventory/hosts
```

## Make Targets

The [makefile](./Makefile) provides the following targets:

- *provision* - Creates a minikube cluster with profile name
- *configure* - Creates a minikube cluster with profile name
- *unprovision* - Deletes the created minikube cluster

### Examples

To provision a cluster with *OpenShift Service Mesh* run:

```shell
cd $REPO_HOME
cp $REPO_HOME/cluster/examples/servicemesh.yml $REPO_HOME/cluster/project/playbook.yml
make configure
```

To provision a cluster with *OpenShift Serverless* run:

```shell
cd $REPO_HOME
cp $REPO_HOME/cluster/examples/serverless.yml $REPO_HOME/cluster/project/playbook.yml
make configure
```

To provision a cluster with *OpenShift Pipelines, OpenShift Serverless and Argo CD* run:

```shell
cd $REPO_HOME
cp $REPO_HOME/cluster/examples/serverless_pipelines_argocd.yml $REPO_HOME/cluster/project/playbook.yml
make configure
```

## Tutorials

Based on the installation the following Tutorials might be of help:

- [Knative Tutorial](https://dn.dev/knative-tutorial)
- [Tekton Tutorial](https://dn.dev/tekton-tutorial)

## Adding python modules

Any python module that you need to install can added to the `$REPO_HOME/requirements.txt`, this file will be processed automatically before the play runs.

## Adding extra roles and collections

Any roles/collections that need to installed can be added to the `$REPO_HOME/requirements.yml`, this file will be processed automatically before the play runs.

Please check [Galaxy](https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-roles-from-galaxyguide) for the structure of `requirements.yml` file.

## License

[Apache v2](https://github.com/kameshsampath/openshift-spice-runner/tree/master/LICENSE)

## Author Information

[Kamesh Sampath](mailto:kamesh.sampath@hotmail.com)

## Issues

[Issues](https://github.com/kameshsampath/openshift-spice-runner/issues)
