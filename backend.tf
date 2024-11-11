terraform {
  backend "gcs" {
    bucket = "terraformbackendmysqlapplication"
    prefix = "jenkins/state"
  }
}
