data "vultr_ssh_key" "my_ssh_key" {
  filter {
    name = "name"
    values = ["work-wsl"]
  }
}

resource "vultr_block_storage" "my_blockstorage" {
  count = 0
  label = "vultr-block-storage"
  size_gb = 40
  region = "sto"
  block_type = "storage_opt"
  #attached_to_instance = vultr_instance.server[0].id
  live = true
}

resource "vultr_vpc2" "vpc" {
  count = 1
  description = "VPC network"
  region = "sto"
}

resource "vultr_instance" "server" {
  count = 1
  label = "server-${count.index + 1}"
  hostname = "server-${count.index + 1}"
  plan = "vc2-1c-1gb"
  region = "sto"
  os_id = "2284"
  enable_ipv6 = true
  ssh_key_ids = [data.vultr_ssh_key.my_ssh_key.id]
  vpc2_ids = [vultr_vpc2.vpc[0].id]
}

output "main_ip" {
  value = vultr_instance.server.*.main_ip
  description = "Public IPv4 address"
}

output "cpu_count" {
  value = vultr_instance.server.*.vcpu_count
  description = "Number of CPU cores"
}

output "ram_mb" {
  value = vultr_instance.server.*.ram
  description = "The amount of memory available on the server in MB"
}

output "disk_gb" {
  value = vultr_instance.server.*.disk
  description = "The amount of total disk space on the server in GB"
}

output "hostname" {
  value = vultr_instance.server.*.hostname
}

output "default_password" {
  value = vultr_instance.server.*.default_password
  sensitive = true
}
