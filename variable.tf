variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "private_key" {
  type    = string
  default = "~/testjob_ansible/ssh_keys/ansible_key"
}

