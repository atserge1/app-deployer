provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "namespace" {
  source = "../modules/terraform-k8s-namespace"
  name   = "test"
  annotations = {
    env = "test"
  }
  labels = {
    env = "test"
  }


}


module "application" {
  source               = "../modules/terraform-helm-local"
  deployment_name      = "test"
  deployment_namespace = "test"
  deployment_path      = "../charts/application"
  values_yaml          = <<EOF
    EOF

}