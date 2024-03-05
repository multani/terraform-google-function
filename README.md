# Terraform module to manage Google Cloud Function

This is a personal (opiniated) Terraform module to manage [Google Cloud Function](https://cloud.google.com/functions/docs/).

## How to use?

```hcl
module "stuff" {
  source  = "app.terraform.io/multani/function/google"
  version = "1.0.0"

  name        = "do-stuff"
  description = "Do some stuff"

  location    = "europe-west6"
  runtime     = "python312"
  entry_point = "stuff_doer"

  source_code = {
    bucket = module.functions.bucket
    object = module.functions.object
  }

  environment_variables = {
    SOMETHING = "stuff"
  }
}

# Authorize stuff to read GCP secrets
resource "google_project_iam_member" "stuff" {
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${module.stuff.service_account_email}"
  project = data.google_project.this.project_id
}
```

### Help me, it doesn't work!

> [!IMPORTANT]
>
> If you are trying to deploy this module and you authenticate on Google Cloud
> using a GCP service account (for instance, when running Terraform via
> Terraform Cloud or a similar service ; in the example below, the service
> account is called `terraform-sa`), you may get the following error while
> trying to deploy the function:
>
> > Error while updating cloudfunction configuration: googleapi: Error 403: Missing necessary permission `iam.serviceAccounts.actAs` for `terraform-sa` on the service account `fun-stuff@my-gcp-project.iam.gserviceaccount.com`.
> >
> > Grant the role `roles/iam.serviceAccountUser` to `terraform-sa` on the service account `functions@multani-admin.iam.gserviceaccount.com`.
> > You can do that by running `gcloud iam service-accounts add-iam-policy-binding functions@multani-admin.iam.gserviceaccount.com --member=terraform-sa --role=roles/iam.serviceAccountUser`.
> > In case the member is a service account please use the prefix `serviceAccount:` instead of `user:`.
> >
> > If this is a cross-project service account usage ask a project owner to grant you the `iam.serviceAccountUser` role on the service account and/or set the `iam.disableCrossProjectServiceAccountUsage` org policy to `NOT ENFORCED` on the service account project.
> >
> > Please visit https://cloud.google.com/functions/docs/troubleshooting for in-depth troubleshooting documentation.
>
> Read the [IAM Cloud Function
> documentation](https://developer.hashicorp.com/terraform/cloud-docs/workspaces)
> for more information.

In this case, reconfigure the "deployer" service account with the following:

```hcl
resource "google_service_account_iam_binding" "stuff" {
  service_account_id = module.stuff.service_account_name
  role               = "roles/iam.serviceAccountUser"

  # The service account that tries to deploy the Cloud Function
  members = ["serviceAccount:${google_service_account.deployer.email}"]
}
```
