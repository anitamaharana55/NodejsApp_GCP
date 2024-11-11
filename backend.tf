terraform {
  backend "gcs" {
    bucket = "terraformbackendmysqlapplication"
    prefix = "terraform/jenkinsstate"
  }
}
