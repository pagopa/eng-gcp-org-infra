# eng-gcp-authorization

brew install --cask google-cloud-sdk

gcloud auth login

gcloud auth application-default login

gcloud config set project organization-443016

gcloud services enable cloudidentity.googleapis.com

// gcloud config set billing/quota_project organization-443016

# eng-gcp-authorization

brew install --cask google-cloud-sdk

gcloud auth login

gcloud auth application-default login

gcloud config set project organization-443016

gcloud services enable cloudidentity.googleapis.com

// gcloud config set billing/quota_project organization-443016

gcloud auth application-default set-quota-project organization-443016

---
## Repository Structure & Details (Auto-generated)

### Scopo
Crea e mantiene la landing zone GCP (progetti core, cartelle, logging/sentinel) come base organizzativa comune, includendo integrazione Sentinel/Audit.

### Cartelle
- `src/00_main.tf`: progetti e cartelle base, IAM, logging.
- `99_variables.tf`: variabili di organizzazione e default.
- `terraform.tfvars`: parametri operativi (org id, billing account).
- `src/11_sentinel_*`: risorse per integrazione Sentinel/Audit Logs.

### Script
Nessuno.

### Workflow
Nessuno.

### Backend
GCS bucket `tfapporg-terraform-state` (prefix `eng-gcp-infra`).

### Note
Lanciare da account con permessi org; usare `gcloud` auth.
