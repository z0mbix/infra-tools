variable "aws_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "ami_regions" {
  type    = list(string)
  default = []
}

variable "ami_source_prefix" {
  type = string
}

variable "ami_source_account" {
  type = map(string)
  default = {
    "redhat" = "309956199498"
    "rocky"  = "679593333241"
    "ubuntu" = "099720109477"
  }
}

variable "build_number" {
  type    = string
  default = "unknown"
}

variable "data_classification" {
  type    = string
  default = "confidential"
}

variable "distro_name" {
  type = string
}

variable "distro_version" {
  type = string
}

variable "encrypt_boot" {
  type    = bool
  default = false
}

variable "owner" {
  type    = string
  default = "platform"
}

variable "skip_ami_creation" {
  type    = bool
  default = false
}

variable "ssh_username" {
  type = map(string)
  default = {
    "redhat" = "ec2-user"
    "rocky"  = "rocky"
    "ubuntu" = "ubuntu"
  }
}

variable "type" {
  type    = string
  default = "base"
}
