
variable "namespace" {
  type = string
}
variable "namespace_labels" {
  type = map(any)
  default = {
    env = "test"
  }
}
variable "namespace_annotations" {
  type = map(any)
  default = {
    env = "test"
  }
}


variable "repository" {}
variable "tag" {}
variable "port" {}
variable "domain" {}
variable "environment" {}
variable "app_name" {}