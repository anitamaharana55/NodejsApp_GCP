variable "name" {
    type = string
  
}
variable "project_id" {
  type = string
}
variable "machine_type" {
    type = string
}
variable "zone" {
    type = string
}
variable "tags" {
    type = list(string)
}

variable "boot_disk" {
  description = "Boot disk configuration"
  type = object({
    initialize_params = object({
      image  = string
      labels = map(string)
    })
  })
}

variable "network_interface" {
    type = object({
      network = string
    })
}
variable "metadata_startup_script" {
    type = string
}