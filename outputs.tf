output "name" {
  description = "The name of the function"
  value       = google_cloudfunctions2_function.this.name
}

output "location" {
  description = "The location of the function"
  value       = google_cloudfunctions2_function.this.location
}

output "service_account_email" {
  description = "The service account email the function runs as"
  value       = google_service_account.this.email
}

output "service_account_name" {
  description = "The FQDN to the service account the function runs as"
  value       = google_service_account.this.name
}

output "uri" {
  description = "The URI to call the function"
  value       = google_cloudfunctions2_function.this.service_config[0].uri
}
