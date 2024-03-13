# Terraform Output Values
output "Ansible_Controller_details" {
  description = "Ansible controller Instance details"
  value = {
    instance_id = aws_instance.ubuntu.id
    key         = aws_instance.ubuntu.key_name
    private_ip  = aws_instance.ubuntu.private_ip
    public_ip   = aws_instance.ubuntu.public_ip
  }
}

output "RHEL_instance_details" {
  description = "RedHat EC2 Instance details"
  value = {
    for idx, instance in aws_instance.rhel-hosts[*] : instance.tags["Name"] => {
      instance_id = instance.id
      key         = instance.key_name
      private_ip  = instance.private_ip
      public_ip   = instance.public_ip
    }
  }
}

output "UBUNTU_instance_details" {
  description = "Ubuntu EC2 Instance details"
  value = {
    for idx, instance in aws_instance.ubuntu-hosts[*] : instance.tags["Name"] => {
      instance_id = instance.id
      key         = instance.key_name
      private_ip  = instance.private_ip
      public_ip   = instance.public_ip
    }
  }
}

