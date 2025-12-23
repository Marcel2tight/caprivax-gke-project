output "cluster_name" {
  value       = local.full_name
  description = "The generated unique name of the cluster"
}

output "kubectl_connection_command" {
  value = "gcloud container clusters get-credentials ${local.full_name} --region ${var.region} --project ${var.project_id}"
}