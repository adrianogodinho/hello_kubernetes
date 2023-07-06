# hello_kubernetes
Experiences with cloud, Kubernetes, and IoC. 


The following steps were followed in order to create a Kubernetes cluster in the local machine using Kind.

Goals
a. Install Kubernetes as container orchestrator
b. Use Terraform as an Infrastructure as a Code solution
c. Install and access Kubernetes Dashboard to have a visual glimpse of Kubernetes resources.
d. Install ArgoCD to manage application deployments exploring the GitOps concept


1. Install kubectl

    [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

2. Create a Kubernetes cluster

    For development/test purposes, create a cluster of docker containers by using kind.

    1. ~~Install dependencies: docker and go~~

        ~~> brew install docker~~


        ~~> brew install go   ~~

    2. Install kind

        ~~> go install sigs.k8s.io/kind@v0.20.0~~


        > brew install kind \


    3. Install docker from the dmg file [https://docs.docker.com/desktop/install/mac-install/](https://docs.docker.com/desktop/install/mac-install/)

        (brew didn't started dockerd)eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    4. Create cluster

        > kind create cluster


        Creates a single note cluster

    5. Check cluster info

        > kubectl cluster-info

3. Create the kubernets cluster using terraform to exercise Infrastructure as Code
    6. Install Terraform

        > brew install terraform

    7. Create Terraform project

 	            Created a terraform folder

		Then a main.tf source importing a kubernetes and kubectl providers

		Providers are targeting the ~/.kube/config 

		Also created the argo.tf, with 2 terraform resource: 1 kubernetes namespace and a kubernetes yaml configuration (it installs all the argocd infra to the cluster).



4. Install kubernets dashboard to exercise the concepts of deployment
    8. Create command on terraform to include the yaml to run the service on cluster
        * It created a K8s namespace (a set of k8s resource)

            kubectl describe pod --namespace=kubernetes-dashboard kubernetes-dashboard-6967859bff-sf2qk

    9. Create a proxy on the local machine to the K8s cluster, so that we can access the k8s server api by calling the loopback address]

        	kubectl proxy

    10. Use the instruction to create an RBAC account and credentials to access the kubernetes-dashboard

        [https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md)

    11. Access the kubernets-dashboard to check all the k8s resources

        [http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=default](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=default)

5. Install Ambassador, Ingress controller

emissary-apiext-6594d7c648-7dq9b    0/1     CrashLoopBackOff 


        wget [https://app.getambassador.io/yaml/edge-stack/latest/aes.yaml](https://app.getambassador.io/yaml/edge-stack/latest/aes.yaml)


        wget https://app.getambassador.io/yaml/edge-stack/latest/aes.yaml    



6. ArgoCD to manage the application deployments

    Why? GitOps concept - it monitors git and guarantees that the apps are in the same state; continuous delivery ---> Use ArgoCD as a tool to improve the way you do your deployments, by relying on the state on git.

    12. Access the Argo CD API service by configuring Ingress
7. T

TROUBLESHOOTING

1. The terraform kubectl_manifest provider applies only the first document on the yaml.

        [https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/kubectl_file_documents](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/kubectl_file_documents)

2. Error when installing ambassador-crd

    >kubectl get pod -n ambassador


    emissary-apiext-6594d7c648-7dq9b    0/1     CrashLoopBackOff 


    When a Pod is in the "CrashLoopBackOff" state, it means that the container within the Pod has crashed and is being restarted repeatedly.


    >kubectl describe pod &lt;pod-name>


    It was an error on namespace, terraform was forcing everything on ambassador namespace, which is not correct by this installation.


GLOSSARY



1. CRD - CRD stands for Custom Resource Definition. Custom Resource Definitions are a feature of Kubernetes that allow users to define their own custom resources and extend the Kubernetes API with new object types.
2. Helm - Helm is a package manager for Kubernetes that allows you to deploy and manage applications on your cluster
3. IaC - Infrastructure as a Service - ex: Terraform
4. ~/.kube/config  --- this is the configuration file used by the _kubectl_ command, it contains informations about how to access the Kubernetes cluster 
5. Ingress - In Kubernetes, an Ingress is an API object that provides external access to services within a cluster.
