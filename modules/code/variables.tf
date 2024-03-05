variable "source_dir" {
  description = "The directory in which the source code of the Cloud Function is"
  type        = string
}

variable "name" {
  description = "The name of the Cloud Function, as stored in the Google Cloud Storage bucket"
  type        = string
}

variable "bucket_name" {
  description = "The Google Cloud Storage bucket name to store the Cloud Function code in"
  type        = string
}

variable "metadata" {
  description = "Key/value to associate with the source code"
  default     = {}
  type        = map(string)
}
