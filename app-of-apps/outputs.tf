output "argocd_repo" {
  value = argocd_repository.this.repo
}

output "argocd_application" {
  value = argocd_application.apps.metadata[0].name
}
