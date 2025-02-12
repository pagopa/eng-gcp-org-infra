# eng-gcp-authorization

brew install --cask google-cloud-sdk

gcloud auth login

gcloud auth application-default login

gcloud config set project organization-443016

gcloud services enable cloudidentity.googleapis.com

// gcloud config set billing/quota_project organization-443016

gcloud auth application-default set-quota-project organization-443016
