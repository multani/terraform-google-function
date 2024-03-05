# Terraform module to manage Google Cloud Function source code

This is a personal (opiniated) Terraform module to manage source code for [Google Cloud Function](https://cloud.google.com/functions/docs/).

It uploads source code to a Google Cloud Storage bucket and "version" it using a checksum.


## How to use?

```hcl
module "functions" {
  source  = "multani/function/google//modules/code"
  version = "1.0.2"

  name        = "my-functions"
  source_dir  = "${path.module}/src"

  # A previously created storage bucket
  bucket_name = data.google_storage_bucket.functions.name
}
```

Use the following output to create a Cloud Function:

* `bucket`: the name of the bucket where the source code is stored
* `object`: the name of the object inside the bucket, where the source code is stored
