terraform {

  required_version = ">= 0.13"

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.18.1"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

# Plugin used to issue Kubernetes commands to the Kubernetes cluster
# note the config_path configuration, it instructs the plugin where it can find the host and credentials necessary to
# access the cluster. For this project, this file is created by Kind.
provider "kubectl" {
  config_path = "~/.kube/config"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}