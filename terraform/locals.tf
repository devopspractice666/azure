locals {
  location = var.location

  web_private_ip         = "10.0.1.4"
  monitoring_private_ip  = "10.0.2.4"
  web_subnet_cidr        = "10.0.1.0/24"
  monitoring_subnet_cidr = "10.0.2.0/24"

  tags = {
    project = "azure1task"
  }

  web_custom_data = base64encode("#cloud-config\n${yamlencode({
    package_update = true
    packages       = ["nginx"]
    write_files = [
      {
        path        = "/opt/azure1/nginx/nginx.conf"
        permissions = "0644"
        content     = file("${path.module}/../config/nginx/nginx.conf")
      },
      {
        path        = "/opt/azure1/nginx/default.conf"
        permissions = "0644"
        content     = file("${path.module}/../config/nginx/conf.d/default.conf")
      },
      {
        path        = "/opt/azure1/nginx/html/index.html"
        permissions = "0644"
        content     = file("${path.module}/../config/nginx/html/index.html")
      },
      {
        path        = "/opt/azure1/nginx/html/logo.svg"
        permissions = "0644"
        content     = file("${path.module}/../config/nginx/html/logo.svg")
      },
    ]
    runcmd = [
      "cp /opt/azure1/nginx/nginx.conf /etc/nginx/nginx.conf",
      "cp /opt/azure1/nginx/default.conf /etc/nginx/conf.d/default.conf",
      "cp /opt/azure1/nginx/html/index.html /opt/azure1/nginx/html/logo.svg /var/www/html/",
      "nginx -t",
      "systemctl enable nginx",
      "systemctl restart nginx",
    ]
  })}")

  monitoring_custom_data = base64encode("#cloud-config\n${yamlencode({
    package_update = true
    packages       = ["docker.io", "docker-compose-v2"]
    write_files = [
      {
        path        = "/opt/azure1/monitoring/docker-compose.yml"
        permissions = "0644"
        content     = file("${path.module}/../config/monitoring/docker-compose.yml")
      },
      {
        path        = "/opt/azure1/monitoring/prometheus/prometheus.yml"
        permissions = "0644"
        content     = file("${path.module}/../config/monitoring/prometheus/prometheus.yml")
      },
      {
        path        = "/opt/azure1/monitoring/loki/loki.yml"
        permissions = "0644"
        content     = file("${path.module}/../config/monitoring/loki/loki.yml")
      },
      {
        path        = "/opt/azure1/monitoring/grafana/provisioning/datasources/datasources.yml"
        permissions = "0644"
        content     = file("${path.module}/../config/monitoring/grafana/provisioning/datasources/datasources.yml")
      },
    ]
    runcmd = [
      "systemctl enable --now docker",
      "docker compose -f /opt/azure1/monitoring/docker-compose.yml up -d",
    ]
  })}")
}
