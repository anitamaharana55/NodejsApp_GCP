terraform {
  backend "gcs" {
    bucket = "terraformbackendmysqlapplication"
    # prefix = "new/state"
  }
}
