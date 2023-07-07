# hello_kubernetes

This is a Terraform project used to setup a fully functional Kubernetes clusters for educational purposes. 

The following sections walk through the steps to create this clusters with the following characteristics: 
* It is a simulated clusters on local machine created by Kind
* This cluster is composed by 3 nodes: control-pane, worker, worker2 (check cluster-config-kind.yaml)
* The Kubernetes-Dashboard, a graphical tool to manage kubernetes is installed to help to explore this tool concepts.
* ArgoCD tool to enable GitOps 
* Ingress controller to control external access to the clusters (WIP)


# Prerequisites

All the steps on this guide was executed on a Linux machine. To execute the steps guarantee that you have:

1. Homebrew package manager - brew command ([Homebrew](https://docs.brew.sh/Homebrew-on-Linux))
2. kubectl, to manage your Kubernetes cluster from command line ([https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/))
3. Docker, the cluster will e simulated locally by using Docker containers running locally ([Ubuntu Docker Installation](https://docs.docker.com/engine/install/ubuntu/))
4. Kind, to setup the local cluster ([Kind](https://kind.sigs.k8s.io/docs/user/quick-start/)) - or simply
    > brew install kind
5. Terraform, is an open-source infrastructure-as-code (IaC) tool that allows you to define, manage, and provision cloud infrastructure resources in a declarative way ([Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
    > brew install terraform
    
# Setting up the local cluster using Kind

Kind will simulate a kubernetes cluster using Docker containers. With a command is possible to run the bring-up the 
Kubernetes cluster and configure your local machine to access it.

There is also a script on this page to facilitate that if you want to abstract the details:

    > ./create_kind_cluster.sh

The command above will create the cluster as specified on the file cluster-config-kind.yaml. Play with this file to 
change the number of notes you need. By default, it is set to run 3 nodes, being 2 workers and 1 panal-admin.

The kind command also create the file ~/.kube/config, with all the info necessary so that the command kubectl can run
commands for the recent created cluster.

Run the following command to get overall info about the cluster:

    > kubectl cluster-info

You can check the nodes by running:

    > kubectl get nodes

# Terraform and infrastructure as a code and Kubectl Provider

All configurations and commands are defined as a Terraform code (\*.tf files).

Terraform is based on Providers. A provider is a plugin that allows Terraform to interact with a specific 
cloud or infrastructure platform. It serves as the bridge between Terraform and the target platform, enabling Terraform 
to provision and manage resources within that platform. On this project, we interact with the Kubernetes cluster, so we 
configure the Kubectl provider. 

You can check details about the Providers configuration by opening the file main.tf. 

Check for more info on the [Terraform Page](https://developer.hashicorp.com/terraform/tutorials).
  
# Kubernetes Dashboard - a visual tool to manage Kubernetes

To Deploy kubernetes dashboard, you can use the Kubernetes Manifest in k8s_dashboard/k8s_dash.yaml. Check how it is 
deployed using Terraform by opening k8s_dashboard.tf.

To do a deploy run:

    > terraform init
    > terraform apply

If successfully executed, the previous command will deploy the Kubernetes-dashboard on your cluster. 

All resources related to Kubernetes-dashboard are created under the kubernetes-dashboard namespace. Play with the 
following command to review what was deployed:

    > kubectl get all -n kubernetes-dashboard

To access the graphical UI, you can start the Kubernetes Proxy to access the Kubernetes API by referencing localhost.

    > kubectl proxy

After running this command, open the following address in a browser.

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

It will ask for a credential, you can create a token by running:

> kubectl -n kubernetes-dashboard create token admin

Full info on how to create the credential [here](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md).

(Note that the account creation was already done by Terraform, check k8s_dash/k8s_dash_admin.yaml)

# ArgoCD to manage the application deployments

Why? GitOps concept - it monitors git and guarantees that the apps are in the same state; continuous delivery ---> 
Use ArgoCD as a tool to improve the way you do your deployments, by relying on the state on git.

TBD.: port forward

# Configuring Ingress

WIP

# Troubleshooting

1. The terraform kubectl_manifest provider applies only the first document on the yaml.
    It is not enough to point to Kubernetes File, it may be a Yaml composed by more than a document, if you just point
    to the file, it will apply only the first document in the file. So it is necessary to instruct Terraform to read
    all documents. [Handling yaml Files on Terraform kubectl provider](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/kubectl_file_documents)

# Glossary

1. CRD - CRD stands for Custom Resource Definition. Custom Resource Definitions are a feature of Kubernetes that allow users to define their own custom resources and extend the Kubernetes API with new object types.
2. Helm - Helm is a package manager for Kubernetes that allows you to deploy and manage applications on your cluster
3. IaC - Infrastructure as a Service - ex: Terraform
4. Kubernetes Manifest - a declarative configuration file written in YAML or JSON format that describes the desired state of Kubernetes resources. It defines the specifications for creating and managing Kubernetes objects, such as pods, deployments, services, and ingress rules.
5. ~/.kube/config  --- this is the configuration file used by the _kubectl_ command, it contains informations about how to access the Kubernetes cluster 
6. Ingress - In Kubernetes, an Ingress is an API object that provides external access to services within a cluster.
