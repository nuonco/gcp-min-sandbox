# gcp-min-sandbox

Minimal GCP sandbox for Nuon BYOC deployments. Provisions the base infrastructure needed to run a Nuon install runner on GCP VMs — without a Kubernetes cluster. For a GKE-based sandbox see [gcp-gke-sandbox](https://github.com/nuonco/gcp-gke-sandbox).

## Resources Created

- **VPC** — new network (or reference an existing one)
- **Artifact Registry** (Docker) — image storage for runner containers
- **Cloud DNS Zones** — public and internal (optional, controlled by `enable_nuon_dns`)
- **GCP APIs** — all required project services enabled automatically

## Prerequisites

### Required IAM Permissions

The service account or user running Terraform needs:

- Compute Network Admin (`roles/compute.networkAdmin`)
- Artifact Registry Admin (`roles/artifactregistry.admin`)
- DNS Administrator (`roles/dns.admin`)
- Service Usage Admin (`roles/serviceusage.serviceUsageAdmin`)

### Bootstrap API

`iamcredentials.googleapis.com` must be enabled before the first `terraform apply` because the Google provider calls it during init, before any resource can run:

```bash
gcloud services enable iamcredentials.googleapis.com --project=<PROJECT_ID>
```

All other APIs are enabled automatically by `services.tf`.

## Quick Start

```bash
gcloud auth application-default login --project=<PROJECT_ID>
terraform init
terraform plan -var-file=example.tfvars
terraform apply -var-file=example.tfvars
```

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| `nuon_id` | Nuon install identifier, used to name all resources | — | yes |
| `project_id` | GCP project ID | — | yes |
| `region` | GCP region | — | yes |
| `gcp_credentials_base64` | Base64-encoded service account JSON | `""` | no |
| `network` | Name of an existing VPC (empty = create new) | `""` | no |
| `enable_nuon_dns` | Create Cloud DNS zones | `"false"` | no |
| `public_root_domain` | Public DNS domain (required when DNS enabled) | `""` | no |
| `internal_root_domain` | Internal private DNS domain | `""` | no |
| `labels` | Additional labels for all resources | `{}` | no |
| `tags` | Nuon resource tags, merged with labels | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `account` | `project_id`, `region` |
| `vpc` | `network`, `network_self_link` |
| `gar` | `repository_id`, `repository_url`, `registry_url` |
| `nuon_dns` | `enabled`, `public_domain`, `internal_domain` |
| `availability_zones` | Comma-separated list of available zones in the region |
