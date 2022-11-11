data "amazon-ami" "source_ami" {
  region      = var.aws_region
  owners      = [lookup(var.ami_source_account, var.distro_name, "")]
  most_recent = true
  filters = {
    name                = var.ami_source_prefix
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
}

data "git-commit" "cwd-head" {}

locals {
  ami_name   = "${var.name_prefix}-${var.type}-${var.distro_name}-${var.distro_version}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  git_author = data.git-commit.cwd-head.author
  git_sha    = substr(data.git-commit.cwd-head.hash, 0, 8)

  tags = {
    BuildNumber        = var.build_number
    BuildUrl           = "https://jenkins.hopefully.not/builds/${var.build_number}"
    DataClassification = var.data_classification
    DistroName         = var.distro_name
    DistroVersion      = var.distro_version
    GitCommit          = local.git_sha
    GitAuthor          = local.git_author
    GitUrl             = "https://gitlab.com/someorg/infra/commit/${local.git_sha}"
    ManagedBy          = "packer (${packer.version})"
    Name               = local.ami_name
    Owner              = var.owner
    SourceAmi          = "{{ .SourceAMI }} ({{ .SourceAMIName }})"
    SourceAmiOwner     = "{{ .SourceAMIOwner }} ({{ .SourceAMIOwnerName }})"
    Type               = var.type
  }
}

source "amazon-ebs" "ami" {
  ami_name                                  = local.ami_name
  ami_description                           = "${var.type} ${var.distro_name} ${var.distro_version} AMI"
  ami_regions                               = var.ami_regions
  ebs_optimized                             = true
  encrypt_boot                              = var.encrypt_boot
  instance_type                             = var.aws_instance_type
  region                                    = var.aws_region
  ssh_username                              = lookup(var.ssh_username, var.distro_name, "")
  source_ami                                = data.amazon-ami.source_ami.id
  tags                                      = local.tags
  run_tags                                  = local.tags
  run_volume_tags                           = local.tags
  snapshot_tags                             = local.tags
  skip_create_ami                           = var.skip_ami_creation
  shutdown_behavior                         = "terminate"
  temporary_security_group_source_public_ip = true
  # iam_instance_profile = ""

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "optional"
    instance_metadata_tags = "enabled"
  }
}

build {
  name    = "create-${var.distro_name}-${var.distro_version}-ami"
  sources = ["source.amazon-ebs.ami"]

  provisioner "shell" {
    execute_command = "sudo -H -S bash {{.Path}}"
    scripts = [
      "../scripts/common/bootstrap.sh"
      "../scripts/${var.distro_name}/bootstrap.sh"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "../../ansible/${var.type}.yml"
    extra_arguments = [
      "--diff",
      "--verbose",
      "--tags=build",
      "--extra-vars=ami_build=true",
      "--extra-vars=type=${var.type}",
    ]
  }

  provisioner "shell" {
    execute_command = "sudo -H -S bash {{.Path}}"
    scripts = [
      "../scripts/${var.distro_name}/cleanup.sh"
      "../scripts/common/cleanup.sh"
    ]
  }
}
