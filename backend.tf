terraform {
  backend "gcs" {
    bucket = "an8249"
    prefix = "new/state"
  }
}
