variable "argocd_server" {
  type        = string
  description = "ArgoCD server address"
}

variable "argocd_username" {
  type        = string
  description = "ArgoCD username"
}

variable "argocd_password" {
  type        = string
  description = "ArgoCD password"
  sensitive   = true
}

variable "argocd_namespace" {
  type        = string
  description = "Namespace where ArgoCD is installed"
  default     = "argocd"
}

variable "repo_url" {
  type        = string
  description = "Git repository URL"
}

variable "repo_username" {
  type        = string
  description = "Git repository username"
}

variable "repo_password" {
  type        = string
  description = "Git repository password"
  sensitive   = true
}

variable "app_namespace" {
  type        = string
  description = "Namespace where applications will be deployed"
  default     = "default"
}
