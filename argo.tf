

data "kubectl_file_documents" "argo_install_docs" {
  content = file("${path.module}/argo/argo.yaml")
}

data "kubectl_file_documents" "argo_config_docs" {
  content = file("${path.module}/argo/argo_config.yaml")
}

resource "kubernetes_namespace" "argo_namespace" {
  metadata {
    name = "argo"
  }
}

resource "kubectl_manifest" "argo_install" {
  count = length(data.kubectl_file_documents.argo_install_docs.documents)
  yaml_body = element(data.kubectl_file_documents.argo_install_docs.documents, count.index)
  override_namespace = "argo"
}

resource "kubectl_manifest" "argo_config" {
  count = length(data.kubectl_file_documents.argo_config_docs.documents)
  yaml_body = element(data.kubectl_file_documents.argo_config_docs.documents, count.index)
  override_namespace = "argo"
}