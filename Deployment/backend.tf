terraform {
  backend "gcs" {
    bucket = "terraform-project-class"
    prefix = "/dev/mnt/PavelTopal/project_infrastructure/project_infrastructure/2.tools-setup"
  }
}
