project_config = [
  {
    name           = "gcp-cloudrun-nodejs-mysql-app"
    project_id     = "gcp-cloudrun-nodejs-mysql-app"
    org_id         = "501043380274"
    enable_network = false
  }
]
VPC_config = [
  {
    name                            = "test-vpc"
    auto_create_subnetworks         = "false"
    routing_mode                    = "GLOBAL"
    project                         = "gcp-cloudrun-nodejs-mysql-app"
    description                     = "new vpc"
    delete_default_routes_on_create = "false"
    mtu                             = 0
    subnet_name                     = "test-subnetwork"
    ip_cidr_range                   = "10.2.0.0/16"
    region                          = "us-central1"
    network                         = "test-vpc"
    secondary_ip_range = [{
      range_name    = "tf-test-secondary-range-update1"
      ip_cidr_range = "192.168.64.0/24"
    }]
    allow = {
      protocol = "tcp"
      ports    = ["80"]
    }
    source_ranges = ["0.0.0.0/0"]
    direction     = "INGRESS"
    target_tags   = ["http-server"]

}]
svc_config = [{
  project      = "gcp-cloudrun-nodejs-mysql-app"
  account_id   = "test-service-account"
  display_name = "test Service Account"
  description  = "This is a service account created by Terraform."
  role = "roles/iam.serviceAccountUser"
}]
registry_config = [
  {
    project = "gcp-cloudrun-nodejs-mysql-app"
    # location = "US"
    location      = "us-central1"
    repository_id = "test-repository"
    description   = "example docker repository"
    format        = "DOCKER"
  }
]
cloudrunsql_config = [
  {
    name       = "test-cloudrun-srv"
    location   = "us-central1"
    project_id = "gcp-cloudrun-nodejs-mysql-app"
    image      = "gcr.io/gcp-cloudrun-nodejs-mysql-app/nodejsapp@sha256:41d634eebdc40336f4458500771b82346b235b74383ad8d728c58b6a4b87af9a"
    maxScale   = "10"
    sql_name   = "cloudrun-sql"

    client-name                = "terraform"
    autogenerate_revision_name = true
    timeout_seconds            = 6000
    service_account_name       = "nodejsdemo@gcp-cloudrun-nodejs-mysql-app.iam.gserviceaccount.com"
    envs = {
      "port"             = "3000"
      "projectid"        = "277275469326"
      "dbconnectionname" = "gcp-cloudrun-nodejs-mysql-app:us-central1:cloudrun-sql"

    }

  }
]
sql_config = [
  {
    location            = "us-central1"
    project_id          = "gcp-cloudrun-nodejs-mysql-app"
    sql_name            = "cloudrun-sql"
    database_version    = "MYSQL_5_7"
    tier                = "db-f1-micro"
    deletion_protection = "false"
    sql_user_name       = "nodejsuser"
    sql_user_pass       = "Wissen12345"

  }
]
secret_config = [{
  secret_id = "secret"
  project   = "gcp-cloudrun-nodejs-mysql-app"
  label     = "my-label"
  location  = "us-east1"
}]