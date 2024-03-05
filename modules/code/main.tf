data "archive_file" "code" {
  type = "zip"

  source_dir = var.source_dir

  output_file_mode = "0666"
  output_path      = "${path.module}/build/${var.name}.zip"
}

resource "google_storage_bucket_object" "this" {
  # Interpolate the hash of the archive file in the name: when the content of
  # the ZIP file changes (because the source code changed), the bucket object
  # will be recreated and this will also force the recreation/update of the
  # Google Cloud Function.
  name = "${var.name}-${data.archive_file.code.output_md5}.zip"

  bucket = var.bucket_name
  source = data.archive_file.code.output_path

  metadata = var.metadata
}
