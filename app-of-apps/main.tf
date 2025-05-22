terraform {
  required_providers {
    argocd = {
      source  = "oboukili/argocd"
      version = ">= 5.0.2"
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
    project     = "default"
    source {
      repo_url        = var.repo_url
      target_revision = "HEAD"
      path            = "apps"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = var.app_namespace
    }

    sync_policy {
      automated {
        prune      = true
        self_heal  = true
      }
    }
  }
}
