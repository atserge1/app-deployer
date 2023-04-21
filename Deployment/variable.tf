
variable "namespace" {
  description = "Please provide a name for a namespace" 
  type = string
  default = "test"
}

variable "namespace_labels" {
  description = "Please provide a map of labels for a namespace" 
  type = map(any)
  default = {
    env = "test"
  }
}

variable "namespace_annotations" {
  description = "Please provide a map of annotation for a namespace" 
  type = map(any)
  default = {
    env = "test"
  }
}

variable "repository" {
  description = "Please provide a repo for docker image" 
  type = string
  default = "test"
}

variable "app_port" {
  description = "Please provide a port number for an application" 
  type = string
  default = "80"
}

variable "domain" {
  description = "Please provide a domain for an application" 
  type = string
  default = "test"
}

variable "environment" {
  description = "Please provide a name for an environment" 
  type = string
  default = "dev"
}

variable "app_name" {
  description = "Please provide a name for an application" 
  type = string
  default = "test"
}

variable "app_version" {
  description = "Please provide an application version"
  type = string
  default = "2.0.0"
}

variable "project_id" {
  description = "Please provide a project ID for an application" 
  type = string
  default = "test"
}