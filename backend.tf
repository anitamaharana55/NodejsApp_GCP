terraform {
  backend "gcs" {
    bucket = "terraformbackendmysqlapplication"
    prefix = "default.tfstate"
  }
}
