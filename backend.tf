terraform {
  backend "gcs" {
    bucket = "terraformbackendmysqlapplication"
    prefix = "backend/terraform"
  }
}
