
data "kubectl_file_documents" "k8dash_install_docs" {
  content = file("${path.module}/k8s_dash/k8s_dash.yaml")
}

data "kubectl_file_documents" "k8dash_account_docs" {
  content = file("${path.module}/k8s_dash/k8s_dash_admin.yaml")
}

resource "kubectl_manifest" "k8dash_install" {
  count = length(data.kubectl_file_documents.k8dash_install_docs.documents)
  yaml_body = element(data.kubectl_file_documents.k8dash_install_docs.documents, count.index)
}

resource "kubectl_manifest" "k8dash_account" {
  count = length(data.kubectl_file_documents.k8dash_account_docs.documents)
  yaml_body = element(data.kubectl_file_documents.k8dash_account_docs.documents, count.index)
}