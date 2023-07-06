data "kubectl_file_documents" "ambassador_crds_install_docs" {
  content = file("${path.module}/ambassador/aes-crds.yaml")
}

data "kubectl_file_documents" "ambassador_docs" {
  content = file("${path.module}/ambassador/aes.yaml")
}

resource "kubectl_manifest" "ambassador_crds_install" {
  count = length(data.kubectl_file_documents.ambassador_crds_install_docs.documents)
  yaml_body = element(data.kubectl_file_documents.ambassador_crds_install_docs.documents, count.index)
}

resource "kubectl_manifest" "ambassador_install" {
  count = length(data.kubectl_file_documents.ambassador_docs.documents)
  yaml_body = element(data.kubectl_file_documents.ambassador_docs.documents, count.index)
}
