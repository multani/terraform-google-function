output "bucket" {
  value = google_storage_bucket_object.this.bucket
}

output "object" {
  value = google_storage_bucket_object.this.name
}
