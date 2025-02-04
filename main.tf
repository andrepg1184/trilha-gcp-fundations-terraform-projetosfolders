provider "google" {
  project = "andreops-devops-iac"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = "${file("serviceaccount.yaml")}"
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/540829645030"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.SalesForce.name
}


resource "google_project" "andreops2-salesforce-dev" {
  name       = "SalesForce-Dev"
  project_id = "andreops2-salesforce-dev"
  folder_id  = google_folder.Desenvolvimento.name
  auto_create_network=false
  billing_account = "018973-A8340F-83D8E5"

}

# resource "google_project" "andreops-salesforce-prod" {
#   name       = "SalesForce-Prod"
#   project_id = "andreops-salesforce-prod"
#   folder_id  = google_folder.Producao.name
#   auto_create_network=false
#   billing_account = "01B2C4-70459E-F53446"
# }
