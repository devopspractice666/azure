locals {
  location = var.location

  web_private_ip         = "10.0.1.4"
  monitoring_private_ip  = "10.0.2.4"
  web_subnet_cidr        = "10.0.1.0/24"
  monitoring_subnet_cidr = "10.0.2.0/24"

  tags = {
    project = "azure1task"
  }
}
