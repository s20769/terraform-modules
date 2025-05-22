terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = ">= 6.0.0"
    }
  }
}

provider "argocd" {
  server_addr = var.argocd_server
  username    = var.argocd_username
  password    = var.argocd_password
  insecure    = true
}

resource "argocd_repository" "this" {
  repo     = var.repo_url
  username = var.repo_username
  password = var.repo_password
}

resource "argocd_application" "apps" {
  metadata {
    name      = "applications"
    namespace = var.argocd_namespace
  }

  spec {
    project     = "default" # zmień na var.project jeśli inny projekt!
    source {
      repo_url        = var.repo_url
      target_revision = "HEAD"
      path            = "apps"
    }
    destination {
      server    = "https://kubernetes.default.svc/"
      namespace = var.app_namespace
    }
    sync_policy {
      automated {
        prune      = true
        self_heal  = true
      }
    }
  }
  depends_on = [argocd_repository.this]
}
